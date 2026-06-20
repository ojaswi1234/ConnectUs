import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('Check Supabase users columns', () async {
    final supabase = SupabaseClient(
      'https://hkxvlihyacqpfdviyycy.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhreHZsaWh5YWNxcGZkdml5eWN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4OTQxMzksImV4cCI6MjA3MTQ3MDEzOX0.vQDz72Zu6IVglI43t2VUTYVxzeMZbBPRki9zm4_VxF8',
    );
    try {
      final response = await supabase.from('users').select('*').limit(1);
      print("DATABASE_COLUMNS_START");
      print(response.first.keys.toList());
      print("DATABASE_COLUMNS_END");
    } catch (e) {
      print("Error querying users: $e");
    }
  });
}
