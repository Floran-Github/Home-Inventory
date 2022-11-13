import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  //  set token
  Future<void> setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  // getting token
  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
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

  // set username
  Future<void> setid(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("id", id);
  }

  // getting id
  Future<int?> getid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('id');
  }

  // set username
  Future<void> setInvid(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("invid", id);
  }

  // getting id
  Future<int?> getInvid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('invid');
  }

}
