abstract class DataManager {
  String getString(String key, [String? defValue]);

  bool getBool(String key, [bool? defValue]);

  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> removeValue(String key);

  void clear();
}
