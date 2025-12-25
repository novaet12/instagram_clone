import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createProfile({
    required String userId,
    required String username,
  }) async {
    await _client.from('profiles').insert({
      'id': userId,
      'username': username,
    });
  }
}
