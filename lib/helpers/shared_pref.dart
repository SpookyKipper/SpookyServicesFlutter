import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesFunctions {

  static late final SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }


  String? getString(String key) {
    try {
      return preferences.getString(key);
    } catch (e) {
      print('Error reading value: $e');
      return null;
    }
  }

  int? getInt(String key) {
    try {
      return preferences.getInt(key);
    } catch (e) {
      print('Error reading value: $e');
      return null;
    }
  }

  bool? getBool(String key) {
    try {
      return preferences.getBool(key);
    } catch (e) {
      print('Error reading value: $e');
      return null;
    }
  }

  double? getDouble(String key) {
    try {
      return preferences.getDouble(key);
    } catch (e) {
      print('Error reading value: $e');
      return null;
    }
  }

  List<String>? getStringList(String key) {
    try {
      return preferences.getStringList(key);
    } catch (e) {
      print('Error reading value: $e');
      return null;
    }
  }

  Future<bool> setString(String key, String value) {
    try {
      return preferences.setString(key, value);
    } catch (e) {
      print('Error writing value: $e');
      return Future.value(false);
    }
  }

  Future<bool> setInt(String key, int value) {
    try {
      return preferences.setInt(key, value);
    } catch (e) {
      print('Error writing value: $e');
      return Future.value(false);
    }
  }

  Future<bool> setBool(String key, bool value) {
    try {
      return preferences.setBool(key, value);
    } catch (e) {
      print('Error writing value: $e');
      return Future.value(false);
    }
  }

  Future<bool> setDouble(String key, double value) {
    try {
      return preferences.setDouble(key, value);
    } catch (e) {
      print('Error writing value: $e');
      return Future.value(false);
    }
  }

  Future<bool> setStringList(String key, List<String> value) {
    try {
      return preferences.setStringList(key, value);
    } catch (e) {
      print('Error writing value: $e');
      return Future.value(false);
    }
  }

  Future<bool> removeValue(String key) {
    try {
      return preferences.remove(key);
    } catch (e) {
      print('Error removing value: $e');
      return Future.value(false);
    }
  }
}

final sp = SharedPreferencesFunctions();