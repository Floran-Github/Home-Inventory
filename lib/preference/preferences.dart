import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  //  set token
  Future<void> setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  // set username
  Future<void> setUsername(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", username);
  }

  // getting username
  Future<String?> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('username');
  }

  // getting token
  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}
