import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  factory SharedPrefHelper() => _instance;

  SharedPrefHelper._internal();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Save data (Generic)
  Future<void> saveData<T>(String key, T value) async {
    final prefs = await _prefs;

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception("Unsupported Type");
    }
  }

  /// Get data (Generic)
  Future<T?> getData<T>(String key) async {
    final prefs = await _prefs;

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception("Unsupported Type");
    }
  }

  /// Remove a specific key
  Future<void> removeData(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  /// Clear all data
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
