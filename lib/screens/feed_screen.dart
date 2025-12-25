import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PostProvider>().loadFeed());
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();

    if (postProvider.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (postProvider.error != null) {
      return Scaffold(
        body: Center(child: Text(postProvider.error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Instagram Clone')),
      body: ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];
          final user = post['profiles'] as Map<String, dynamic>?;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: user?['avatar_url'] != null
                  ? NetworkImage(user!['avatar_url'])
                  : null,
              child: user?['avatar_url'] == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(user?['username'] ?? 'Unknown'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post['image_url'] != null)
                  Image.network(post['image_url']),
                const SizedBox(height: 4),
                Text(post['caption'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
