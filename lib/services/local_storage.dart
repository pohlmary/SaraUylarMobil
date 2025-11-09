import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static const String _recentHousesKey = 'recent_houses';
  static const String _userTokenKey = 'user_token';
  static const String _offlineReviewsKey = 'offline_reviews';

  static Future<void> saveRecentHouses(List<String> houseIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentHousesKey, houseIds);
  }

  static Future<List<String>> getRecentHouses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentHousesKey) ?? [];
  }

  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTokenKey, token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTokenKey);
  }

  static Future<void> saveOfflineReview(Map<String, dynamic> review) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reviews = prefs.getStringList(_offlineReviewsKey) ?? [];
    reviews.add(jsonEncode(review));
    await prefs.setStringList(_offlineReviewsKey, reviews);
  }

  static Future<List<Map<String, dynamic>>> getOfflineReviews() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reviews = prefs.getStringList(_offlineReviewsKey) ?? [];
    return reviews.map((r) => jsonDecode(r) as Map<String, dynamic>).toList();
  }

  static Future<void> clearOfflineReviews() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_offlineReviewsKey);
  }
}