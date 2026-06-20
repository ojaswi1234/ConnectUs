import 'package:ferry/ferry.dart';
import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _kBackendHttp = 'https://connectus-backend-server.onrender.com/graphql';
const _kBackendWs = 'wss://connectus-backend-server.onrender.com/graphql';

final clientProvider = Provider<Client>((ref) => _buildClient());

/// Injects the current Supabase JWT into every HTTP GraphQL request.
class _AuthLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    final req = token == null
        ? request
        : request.withContextEntry<HttpLinkHeaders>(
            HttpLinkHeaders(headers: {'Authorization': 'Bearer $token'}),
          );
    yield* forward!(req);
  }
}

Client _buildClient() {
  final httpLink = HttpLink(_kBackendHttp);
  final authedHttp = Link.concat(_AuthLink(), httpLink);

  // WebSocket: pass JWT via connectionParams so subscriptions are also authenticated.
  final wsLink = WebSocketLink(
    _kBackendWs,
    autoReconnect: true,
    inactivityTimeout: const Duration(seconds: 30),
    initialPayload: () async {
      final token = Supabase.instance.client.auth.currentSession?.accessToken;
      return token != null
          ? {'Authorization': 'Bearer $token'}
          : <String, dynamic>{};
    },
  );

  final link = Link.split(
    (req) => req.operation.document.definitions
        .whereType<OperationDefinitionNode>()
        .any((n) => n.type == OperationType.subscription),
    wsLink,
    authedHttp,
  );

  return Client(link: link, cache: Cache(store: MemoryStore()));
}
