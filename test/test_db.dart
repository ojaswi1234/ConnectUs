import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('Check Supabase users columns', () async {
    final supabase = SupabaseClient(
      'https://your-supabase-url.supabase.co',
      'your-supabase-anon-key'
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
