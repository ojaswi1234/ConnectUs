import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart'; // <--- IMPORT THIS
import 'package:gql/ast.dart';

// The Provider (This part was correct!)
final clientProvider = Provider<Client>((ref) {
  return initClient();
});

Client initClient() {
  // Road 1: HTTP
  final httpLink =
      HttpLink("https://connectus-backend-server.onrender.com/graphql");

  // Road 2: WebSocket (Must be a link object, not a string)
  final wsLink = WebSocketLink(
    "wss://connectus-backend-server.onrender.com/graphql",
    autoReconnect: true,
    inactivityTimeout:
        const Duration(seconds: 10), // Auto-heal connection if it drops
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
    httpLink,
  );

  final cache = Cache(store: MemoryStore());

  return Client(link: link, cache: cache);
}
