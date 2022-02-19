import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserloggedKey= "ISLOGGEDIN";
  static String sharedPreferenceNameKey= "USERNAMEKEY";
  static String sharedpreferenceEmailKey= "USERMAILKEY";

  // guardando datos para shared preferences

static Future<bool> saveUserloggedlocalInfo(bool isUserloggedIn)async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPreferenceUserloggedKey, isUserloggedIn);
}


  static Future<bool> saveUserNameloggedlocalInfo(String username)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserloggedKey, username);
  }

  static Future<bool> saveUserEmailloggedlocalInfo(String userEmail)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserloggedKey, userEmail);
  }

//obtener datos de shared preference

static Future<bool?>getUserLoggedInSharedPreference()async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(sharedPreferenceUserloggedKey);
}

  static Future<String?> getUserNameloggedlocalInfo()async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserloggedKey) ;
  }

  static Future<String> getUserEmailloggedlocalInfo()async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserloggedKey)!;
  }

}