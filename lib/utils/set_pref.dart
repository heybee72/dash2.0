import 'package:shared_preferences/shared_preferences.dart';

class SetPrefCategory {
  static SharedPreferences? _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setCat(String cat) async =>
      await _preferences!.setString('prefCat', cat);

  static String? getCat() => _preferences!.getString('prefCat');
}
