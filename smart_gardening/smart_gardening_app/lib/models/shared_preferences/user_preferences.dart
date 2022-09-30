import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences; // prima era static SharedPreferences _preferences;

  static const _keyIsDarkTheme = 'isDarkTheme';
  static const _keyLanguage = 'language';
  //static const _keyPlantAPIToken = "PlantAPIToken"; //TODO: remove
  //static const _keyNetatmoAPIToken = "NetatmoAPIToken"; //TODO: remove
  static const _keyShowOnBoarding = "ShowOnBoarding";

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setTheme(bool isDark) async => await _preferences.setBool(_keyIsDarkTheme, isDark);

  static Future setLanguage(String language) async => await _preferences.setString(_keyLanguage, language);

  //static Future setPlantAPIToken(String tokenResponse) async => await _preferences.setString(_keyPlantAPIToken, tokenResponse); //TODO: remove?
  //static Future setNetatmotAPIToken(String tokenResponse) async => await _preferences.setString(_keyNetatmoAPIToken, tokenResponse); //TODO: remove?

  static Future setShowOnBoarding(bool showOnBoarding) async => await _preferences.setBool(_keyShowOnBoarding, showOnBoarding);

  static bool? getIsDarkTheme() => _preferences.getBool(_keyIsDarkTheme); // prima era bool e _preferences.getBool(_keyIsDarkTheme)!;

  static String? getLanguage() => _preferences.getString(_keyLanguage); // prima era return type String e _preferences.getString(_keyLanguage)!;

  //static String? getPlantAPIAccessToken() => _preferences.getString(_keyPlantAPIToken); //TODO: remove
  //static String? getNetatmoAPIAccessToken() => _preferences.getString(_keyNetatmoAPIToken); //TODO: remove

  static bool? getShowOnBoarding() => _preferences.getBool(_keyShowOnBoarding);

}