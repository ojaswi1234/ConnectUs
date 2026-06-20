import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:gql/ast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_exec/gql_exec.dart';

// The Provider (This part was correct!)
final clientProvider = Provider<Client>((ref) {
  return initClient();
});

class AuthLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    var req = request;
    if (token != null) {
      req = request.withContextEntry<HttpLinkHeaders>(
        HttpLinkHeaders(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    }
    yield* forward!(req);
  }
}

Client initClient() {
  // Road 1: HTTP
  final httpLink =
      HttpLink("https://connectus-backend-server.onrender.com/graphql");

  final authLink = AuthLink();
  final authenticatedHttpLink = Link.concat(authLink, httpLink);

  // Road 2: WebSocket (Must be a link object, not a string)
  final wsLink = WebSocketLink(
    "wss://connectus-backend-server.onrender.com/graphql",
    autoReconnect: true,
    inactivityTimeout:
        const Duration(seconds: 10), // Auto-heal connection if it drops
    initialPayload: () async {
      final token = Supabase.instance.client.auth.currentSession?.accessToken;
      if (token != null) {
        return {'Authorization': 'Bearer $token'};
      }
      return {};
    },
  );

  // THE TRAFFIC CONTROLLER
  // Link.split takes 3 arguments:
  // 1. The Check Function
  // 2. The "True" Road (WebSocket)
  // 3. The "False" Road (HTTP)
  final link = Link.split(
    (request) {
      // FIX: Manually check if the request is a Subscription
      return request.operation.document.definitions
          .whereType<OperationDefinitionNode>()
          .any((node) => node.type == OperationType.subscription);
    },
    wsLink,
    authenticatedHttpLink,
  );

  final cache = Cache(store: MemoryStore());

  return Client(link: link, cache: cache);
}
