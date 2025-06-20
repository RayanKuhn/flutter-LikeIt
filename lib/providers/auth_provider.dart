import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _userId;
  String? _email;

  bool _hasTriedAutoLogin = false;
  bool get isInitialized => _hasTriedAutoLogin;

  bool get isLoggedIn => _accessToken != null;
  String? get accessToken => _accessToken;
  String? get userId => _userId;
  String? get email => _email;

  AuthProvider() {
    _tryAutoLogin(); // <------ on le déclenche ici
  }

  Future<void> _tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print("🔎 Lecture prefs : ${prefs.getKeys()}");

    final storedToken = prefs.getString('accessToken');
    final storedUserId = prefs.getString('userId');
    final storedEmail = prefs.getString('email');

    print("➡️ Tentative d'auto-login...");
    if (storedToken != null && storedUserId != null && storedEmail != null) {
      _accessToken = storedToken;
      _userId = storedUserId;
      _email = storedEmail;
      print("✅ Auto-login réussi avec $storedEmail");
    } else {
      print("❌ Aucun token trouvé, pas d'auto-login");
    }

    _hasTriedAutoLogin = true;
    notifyListeners();
  }

  Future<void> login({
    required String accessToken,
    required String userId,
    required String email,
  }) async {
    _accessToken = accessToken;
    _userId = userId;
    _email = email;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);

    notifyListeners();
  }

  Future<void> logout() async {
    _accessToken = null;
    _userId = null;
    _email = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('userId');
    await prefs.remove('email');

    notifyListeners();
  }
}

