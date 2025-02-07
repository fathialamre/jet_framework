import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JetStorage {
  static SharedPreferences? sharedPreferences;
  static FlutterSecureStorage? secureStorage;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = const FlutterSecureStorage();
  }

  static Future<bool> write(
      {required String key, required dynamic value}) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> writeJson(
      {required String key, required dynamic value}) async {
    return await sharedPreferences!.setString(key, json.encode(value));
  }

  static dynamic readJson({required String key}) {
    dynamic value = sharedPreferences!.get(key);
    return value != null ? json.decode(value) : null;
  }

  static dynamic read({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> remove({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  //Secured Data Storage
  static Future<bool> writeSecuredData(
      {required String key, required dynamic value}) async {
    try {
      await secureStorage!.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> readSecuredData({required String key}) async {
    String value = await secureStorage!.read(key: key) ?? '';
    return value;
  }

  static Future<bool> removeSecuredData({required String key}) async {
    try {
      await secureStorage!.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
