import 'package:shared_preferences/shared_preferences.dart';

import 'data_manager.dart';

class DataManagerImpl extends DataManager {
  final SharedPreferences sharedPreferences;

  DataManagerImpl({
    required this.sharedPreferences,
  });

  @override
  void clear() {
    sharedPreferences.clear();
  }

  @override
  bool getBool(String key, [bool? defValue]) {
    return sharedPreferences.getBool(key) ?? defValue ?? false;
  }

  @override
  String getString(String key, [String? defValue]) {
    return sharedPreferences.getString(key) ?? defValue ?? '';
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool> setString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  @override
  Future<bool> removeValue(String key) {
    return sharedPreferences.remove(key);
  }
}
