// lib/services/ferry_client.dart (new file)
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

Client initFerryClient() {
  // Your backend is running on localhost:4000
  // Use 10.0.2.2 for Android emulator
  final link = HttpLink(
      'https://3000-firebase-connectus-1767129935089.cluster-6dx7corvpngoivimwvvljgokdw.cloudworkstations.dev/graphql');

  final client = Client(
    link: link,
    cache: Cache(),
  );

  return client;
}
