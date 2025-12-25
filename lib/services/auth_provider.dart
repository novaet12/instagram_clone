import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Session? _session;
  bool _loading = false;
  String? _error;

  AuthProvider() {
    _session = Supabase.instance.client.auth.currentSession;
    _authService.onAuthStateChange.listen((event) {
      _session = event.session;
      notifyListeners();
    });
  }

  Session? get session => _session;
  bool get isAuthenticated => _session != null;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> signIn(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signIn(email, password);
    } on AuthException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signUp(email, password);
    } on AuthException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() => _authService.signOut();
}
