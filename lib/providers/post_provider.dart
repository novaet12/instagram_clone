import 'package:flutter/foundation.dart';
import '../services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _postService = PostService();
  bool _loading = false;
  List<Map<String, dynamic>> _posts = [];
  String? _error;

  bool get loading => _loading;
  List<Map<String, dynamic>> get posts => _posts;
  String? get error => _error;

  Future<void> loadFeed() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _postService.fetchFeed();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
