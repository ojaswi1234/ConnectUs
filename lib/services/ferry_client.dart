import 'package:ferry/ferry.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
// Generated classes are essential for manual cache updates
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:graphql/client.dart' hide WebSocketLink;

Client initFerryClient() {
 const httpUrl = 'https://connectus-backend-server.onrender.com/graphql';
 // const httpUrl = 'https://4000-firebase-connectus-1767534396452.cluster-zkm2jrwbnbd4awuedc2alqxrpk.cloudworkstations.dev/graphql';
  final wsUrl = httpUrl.replaceFirst('https', 'wss').replaceFirst('http', 'ws');

  // Split traffic: HTTP for Queries/Mutations, WebSockets for Subscriptions
  final link = Link.split(
    (request) => request.isSubscription,
    WebSocketLink(wsUrl),
    HttpLink(httpUrl),
  );

  return Client(
    link: link,
    cache: Cache(),
    // Correct location for updateCacheHandlers
    updateCacheHandlers: {
      'updateGetMessages': (proxy, response, variables) {
        final req = GGetMessagesReq();
        final currentData = proxy.readQuery(req);

        // Handle data from both Mutations (postMessage) and Subscriptions (messageAdded)
        final newMessage =
            response.data?.postMessage ?? response.data?.messageAdded;

        if (newMessage != null && currentData != null) {
          final updatedData = GGetMessagesData(
            (b) => b
              ..messages.replace(currentData.messages)
              ..messages.add(
                GGetMessagesData_messages.fromJson(newMessage.toJson())!,
              ),
          );
          // Manually write the new message into the local cache
          proxy.writeQuery(req, updatedData);
        }
      },
    },
  );
}
