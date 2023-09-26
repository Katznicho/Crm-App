import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:crm_app/controllers/rest/device_rest.dart';
import 'package:crm_app/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_controller.dart';

class DeviceController {
  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // Unique ID for Android devices
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!; // Unique ID for iOS devices
      }
    } catch (e) {}
    saveDeviceIdToSharedPreferences(deviceId);

    return deviceId;
  }

// Function to store the device ID in shared preferences
  void saveDeviceIdToSharedPreferences(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.deviceId, deviceId);
  }

  // Function to retrieve the token (your specific logic will go here)
  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.deviceId)) {
      return prefs.getString(AppConstants.deviceId);
    } else {
      getDeviceId();
      return prefs.getString(AppConstants.deviceId);
    }
  }

  void saveLastSyncedTimeToSharedPreferences(String lastSyncedTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedTime =
        lastSyncedTime; // Converts DateTime to string in ISO 8601 format
    prefs.setString(AppConstants.lastSyncedTime, formattedTime);
  }

  Future<String?> getLastSyncedTimeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formattedTime = prefs.getString(AppConstants.lastSyncedTime);
    if (formattedTime != null) {
      return formattedTime;
    }
    return null;
  }

  Future sendDeviceId() async {
    try {
      // Make the resource request
      final dio = Dio();
      // dio.options.headers['Authorization'] =
      //     "Bearer ${await AuthController().getAccessToken()}";
      String deviceId = await getDeviceId();
      String? lastSyncedTime = await getLastSyncedTimeFromSharedPreferences();
      Map<String, String> syncDetails = {
        "device_Id": deviceId,
        "lastSyncDateTime": "",
        "SyncReport": ""
      };

      final client = DeviceRestClient(dio);
      final response = await client.sendDeviceId(body: syncDetails);
      if (response['lastSyncDateTime'] != null) {
        saveLastSyncedTimeToSharedPreferences(response['lastSyncDateTime']);
      }

      print("=========Device Id==========");
      print(response['lastSyncDateTime']);
      print(response['device_Id']);
      print("====================================");
      return response;
    } catch (e) {
      print("=========Error================");
      print(e);
      print("===========Error===========================");
      return e;
    }
  }
}
