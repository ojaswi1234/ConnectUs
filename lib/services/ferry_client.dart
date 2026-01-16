// lib/services/ferry_client.dart
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:graphql/client.dart' hide WebSocketLink, FetchPolicy;
// Note: OperationType is exported by ferry, so no extra import needed

// Generated classes
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

Client initFerryClient() {
  const httpUrl = 'https://connectus-backend-server.onrender.com/graphql';
  // Ensure WebSocket URL is correct
  final wsUrl = httpUrl.replaceFirst('https', 'wss').replaceFirst('http', 'ws');

  final link = Link.split(
    (request) => request.isSubscription,
    WebSocketLink(wsUrl),
    HttpLink(httpUrl),
  );

  return Client(
    link: link,
    cache: Cache(),
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.NetworkOnly,
    },
    updateCacheHandlers: {
      'updateGetMessages': (proxy, response, variables) {
        // 1. Get the new message
        final mutationData = response.data as GPostMessageData?;
        final subscriptionData = response.data as GOnNewMessageData?;
        final newMessage =
            mutationData?.postMessage ?? subscriptionData?.messageAdded;

        if (newMessage == null) return;

        // 2. Get the Room ID from the request
        final vars = response.operationRequest.vars.toJson();
        final roomId = vars['roomId'] as String;

        // 3. Read the cache specifically for THIS room
        final req = GGetMessagesReq((b) => b..vars.roomId = roomId);
        final currentData = proxy.readQuery(req);

        // 4. Update the list
        if (currentData != null) {
          final updatedData = currentData.rebuild((b) => b
            ..messages
                .add(GGetMessagesData_messages.fromJson(newMessage.toJson())!));
          proxy.writeQuery(req, updatedData);
        }
      },
    },
  );
}
