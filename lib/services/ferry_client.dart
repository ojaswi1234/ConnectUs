import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:gql/ast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gql_exec/gql_exec.dart';

class AuthLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    var req = request;
    if (token != null) {
      req = request.updateContextEntry<HttpLinkHeaders>(
        (headers) => HttpLinkHeaders(
          headers: {
            ...headers?.headers ?? {},
            'Authorization': 'Bearer $token',
          },
        ),
      );
    }
    yield* forward!(req);
  }
}

final clientProvider = Provider<Client>((ref) {
  return initClient();
});

Client initClient() {
  final httpLink = HttpLink("https://connectus-backend-server.onrender.com/graphql");
  final authLink = AuthLink().concat(httpLink);

  final wsLink = TransportWebSocketLink(
    TransportWsClientOptions(
      socketMaker: WebSocketMaker.url(
        () => "wss://connectus-backend-server.onrender.com/graphql"
      ),
      connectionParams: () async {
        final token = Supabase.instance.client.auth.currentSession?.accessToken;
        if (token != null) {
          return {'Authorization': 'Bearer $token'};
        }
        return {};
      },
    ),
  );

  final link = Link.split(
    (request) {
      return request.operation.document.definitions
          .whereType<OperationDefinitionNode>()
          .any((node) => node.type == OperationType.subscription);
    },
    wsLink,
    authLink,
  );

  final cache = Cache(store: MemoryStore());

  return Client(link: link, cache: cache);
}
