import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:graphql/client.dart' hide WebSocketLink; // Correct import

Client initFerryClient() {
  const httpUrl = 'https://connectus-backend-server.onrender.com/graphql';

  // Convert https://... to wss://... for the WebSocket connection
  final wsUrl = httpUrl.replaceFirst('https', 'wss').replaceFirst('http', 'ws');

  final httpLink = HttpLink(httpUrl);

  // WebSocketLink handles the long-lived subscription connection
  final wsLink = WebSocketLink(wsUrl);

  // Split traffic: Subscriptions go to WebSockets, everything else to HTTP
  final link = Link.split(
    (request) => request.isSubscription,
    wsLink,
    httpLink,
  );

  return Client(
    link: link,
    cache: Cache(),
  );
}
