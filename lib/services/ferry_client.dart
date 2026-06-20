import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:gql/ast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/io_client.dart';

class AuthLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final session = Supabase.instance.client.auth.currentSession;
    final token = session?.accessToken;
    
    final authRequest = token != null 
      ? request.updateContextEntry<HttpLinkHeaders>(
          (headers) => HttpLinkHeaders(
            headers: {
              ...headers?.headers ?? {},
              'Authorization': 'Bearer $token',
            },
          ),
        )
      : request;

    yield* forward!(authRequest);
  }
}

// The Provider
final clientProvider = Provider<Client>((ref) {
  return initClient();
});

Client initClient() {
  final httpUrl = dotenv.env['GRAPHQL_HTTP_URL'] ?? "https://connectus-backend-server.onrender.com/graphql";
  final wsUrl = dotenv.env['GRAPHQL_WS_URL'] ?? "wss://connectus-backend-server.onrender.com/graphql";

  // HTTP Link with Certificate Pinning (rejects bad certs)
  final ioClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) {
       // Return false to reject invalid certificates
       return false; 
    };

  final httpLink = HttpLink(
    httpUrl,
    httpClient: IOClient(ioClient),
  );
  
  final authHttpLink = Link.concat(AuthLink(), httpLink);

  // WebSocket Link
  final wsLink = WebSocketLink(
    wsUrl,
    autoReconnect: true,
    inactivityTimeout: const Duration(seconds: 10),
    initialPayload: () async {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        return {'authorization': 'Bearer ${session.accessToken}'};
      }
      return {};
    },
  );

  final link = Link.split(
    (request) {
      return request.operation.document.definitions
          .whereType<OperationDefinitionNode>()
          .any((node) => node.type == OperationType.subscription);
    },
    wsLink,
    authHttpLink,
  );

  final cache = Cache(store: MemoryStore());
  return Client(link: link, cache: cache);
}
