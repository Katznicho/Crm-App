import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

///shared preferences based class and use for save dummy_data
class KernelSave<T> {
  Future<SharedPreferences> setter() async {
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  Future<SharedPreferences> getter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<void> setIndex(int value) async {
    SharedPreferences sharedPreferences = await setter();

    sharedPreferences.setInt("index", value);
  }

  Future<int> getIndex() async {
    SharedPreferences sharedPreferences = await getter();
    return sharedPreferences.getInt("index") ?? 0;
  }
}
