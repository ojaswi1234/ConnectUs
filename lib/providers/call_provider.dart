import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnectUs/services/call_service.dart';

final callServiceProvider = ChangeNotifierProvider<CallService>((ref) => CallService());
