import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchFeed() async {
    final response = await _client
        .from('posts')
        .select('id, caption, image_url, created_at, profiles(id, username, avatar_url)')
        .order('created_at', ascending: false); // [web:20][web:34]
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> createPost({
    required String imageUrl,
    required String caption,
  }) async {
    final userId = _client.auth.currentUser!.id;
    await _client.from('posts').insert({
      'user_id': userId,
      'image_url': imageUrl,
      'caption': caption,
    });
  }
}
