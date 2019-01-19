import 'package:shared_preferences/shared_preferences.dart';

import 'http_client.dart';
import 'dart:convert' as JSON;
import 'user.dart';

class Auth {
  // static methods

  static const String token_key = "last_token_key";

  static Auth authClient;
  Future<SharedPreferences> preferences;

  void setAuth(Auth auth) {
    authClient = auth;
  }

  static Auth getInstance() {
    return authClient;
  } //end of static methods


  String _token;
  HttpClient client;
  User _currentUser;
  //constructor
  Auth() {
    client = HttpClient();
    preferences = SharedPreferences.getInstance();
  }

  String getToken() {
    if (_token == null) {
      preferences.then((prefs) {
        var tmpToken = prefs.get(token_key);
        if (tmpToken == null) {
          return null;
        }
        _token = tmpToken;
      });
    }
    return _token;
  }
  
  bool setToken(String token) {
    try {
      preferences.then((prefs) {
        prefs.setString(token_key, token);
      });
      _token = token;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> signInByEmail(String username, String password) async {
    var result = await client.postWithHeaders(
        "/login", {}, {'username': username, 'password': password});

    var token = result['token'];
    setToken(token);
    if (isDebug()) {
      print("got token: ${token}");
    }

    User currentUser = await getCurrentUser();
    return currentUser;
  }

  bool signOut() {
    try {
    _currentUser = null;
    _token = null;
    return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> getCurrentUser() async {
    if (_token == null) {
      SharedPreferences prefs = await preferences;
      _token = await prefs.get(token_key);
      if (_token == null) return null;
    }

    if (_currentUser == null) {
      var userData = await client.postWithHeaders("/user", getAuthorization(), {});
      var user = User.fromDB(userData);
      return user;
    } else {
      return _currentUser;
    }
  }

  getAuthorization() {
    return {
      'Authorization':'JWT $_token',
    };
  }

  bool isDebug() {
    return true;
  }
}