import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesSource {
  String? getAccessToken();
  void setAccessToken(String authToken);
  void removeAccessToken();

}

class SharedPreferencesSourceImpl extends SharedPreferencesSource{
 
  late final SharedPreferences prefs;

  Future<void> init() =>
      SharedPreferences.getInstance().then((value) => prefs = value);
  @override
  void setAccessToken(String authToken) async {

        prefs.setString('token', authToken);
  }
  
  @override
  String? getAccessToken() {
   
    return prefs.getString('token');
  }
  
  @override
  void removeAccessToken() {
    prefs.remove('token');
  }

  


  
} 