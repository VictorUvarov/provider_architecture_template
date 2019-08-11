import 'package:shared_preferences/shared_preferences.dart';

class KeyStorageService {
  static const LoggedInKey = 'hasLoggedIn';
  static const NightModeKey = 'nightMode';
  static const LocationGrantedKey = 'locationGranted';

  static KeyStorageService _instance;
  static SharedPreferences _preferences;

  static Future<KeyStorageService> getInstance() async {
    if (_instance == null) {
      _instance = KeyStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  bool get hasLoggedIn => _getFromDisk(LoggedInKey) ?? false;
  set hasLoggedIn(bool value) => _saveToDisk(LoggedInKey, value);

  bool get nightMode => _getFromDisk(NightModeKey) ?? false;
  set nightMode(bool value) => _saveToDisk(NightModeKey, value);

  bool get locationGranted => _getFromDisk(LocationGrantedKey) ?? false;
  set locationGranted(bool value) => _saveToDisk(LocationGrantedKey, value);

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
