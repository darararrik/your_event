import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/token_service/token_interface_service.dart';

class TokenService implements ITokenService {
  final SharedPreferences _prefs;

  TokenService(this._prefs);
  @override
  String? getAccessToken() => _prefs.getString("accessToken");
  @override
  String? getRefreshToken() => _prefs.getString("refreshToken");
  @override
  Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    await _prefs.setString("accessToken", accessToken);
    await _prefs.setString("refreshToken", refreshToken);
  }

  @override
  Future<void> deleteTokens() async {
    await _prefs.remove("accessToken");
    await _prefs.remove("refreshToken");
  }
}
