import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static final LocalRepository _instance = LocalRepository._internal();

  SharedPreferences? _preferences;

  LocalRepository._internal();

  factory LocalRepository() => _instance;

  Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async =>
      await _preferences?.setString(key, value);

  String? getString(String key) => _preferences?.getString(key);
}
