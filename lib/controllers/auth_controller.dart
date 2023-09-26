import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:crm_app/controllers/sync_controller.dart';
import 'package:crm_app/sembast_web/sembast_web.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rest/auth_rest.dart';

class AuthController {
  static String ACCESS_TOKEN = "access_token";

  Future<dynamic> signIn(String username, String password) async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    try {
      Map<String, String> user = {"username": username, "password": password};
      final response = await client.signIn(body: user);
      final accessToken = response['access_token'];
      saveAccessToken(accessToken);
      final Map<String, dynamic> decodedTokenDetails =
          decodeAccessToken(accessToken);

      return decodedTokenDetails;
    } catch (e) {
      print("=================================");
      print(e);
      print("======================================");
      return null;
    }
  }

  saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN, accessToken);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(ACCESS_TOKEN)) {
      return "";
    }
    return prefs.getString(ACCESS_TOKEN);
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = await getAccessToken();
    final Map<String, dynamic> decodedTokenDetails =
        decodeAccessToken(accessToken);
    return decodedTokenDetails;
  }

  Future<void> signOut() async {
    final dio = Dio();
    final client = AuthRestClient(dio);

    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await SembastService.clearDatabase();
      final accessToken = await getAccessToken();
      final Map<String, dynamic> decodedTokenDetails =
          decodeAccessToken(accessToken);
      String userId = decodedTokenDetails['sub'];
      await client.signOut(userId);
      await prefs.clear();
    } catch (e) {
      await SembastService.clearDatabase();
      await prefs.clear();

      FlutterLogs.logError("LOGOUT", "Error:", e.toString());
    }
  }

  Map<String, dynamic> decodeAccessToken(String accessToken) {
    return Jwt.parseJwt(accessToken);
  }
}
