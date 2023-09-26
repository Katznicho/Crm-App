import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../local/shared_preferences/save.dart';
import 'status_checker.dart';

import 'package:http/http.dart' show Client, Response;

import '../constants/strings.dart';

/// If you want to use an apiUrl or baseUrl  instead of the default baseUrl defined in Strings.apiUrl or Strings.baseUrl
/// you can set baseUrl and baseUrl in your bloc.
///
///

class ApiProvider<T> {
  Client client = Client();

  Future fetchDataPOST(String apiAddress, Map<String, dynamic> body,
      Function(String data) returnType, Function(Response)? fullResponse,
      {bool needAuth = false,
      Map<String, String>? headers,
      String? baseUrl,
      String? bearer}) async {
    Response response;
    String url = (baseUrl ?? Strings.apiUrl) + apiAddress;
    headers = {};

    headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
    });

    if (needAuth) {
      String authJwt = await Save().getAuth();
      url = (baseUrl ?? Strings.apiUrlNeedAuth) + apiAddress;
      bearer == null
          ? headers.addAll({"Authorization": "Bearer $authJwt"})
          : headers.addAll({"Authorization": bearer});
    }

    debugPrint(url);
    try {
      debugPrint(headers.toString());
      response = await client
          .post(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(const Duration(seconds: Strings.requestTimeOut));
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      return returnType(getError(RequestError.timeOut));
    } on Exception {
      //(e.toString());
      return returnType(getError(RequestError.noNet));
    }

    if (kDebugMode) {
      print(fullResponse != null);
    }
    if (fullResponse != null) fullResponse(response);

    String data = utf8.decode(response.bodyBytes).toString();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    // stderr.writeln(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return returnType(data);
    } else if (response.statusCode == 401) {
      return Future(() => returnType(getError(RequestError.bugFound)));
    } else {
      return Future(() => returnType(getError(RequestError.unknown)));
    }
  }

  Future fetchDataPut(String apiAddress, Map<String, dynamic> body,
      Function(String data) returnType, Function(Response)? fullResponse,
      {bool needAuth = false,
      Map<String, String>? headers,
      String? baseUrl,
      String? bearer}) async {
    Response response;
    String url = (baseUrl ?? Strings.apiUrl) + apiAddress;
    headers = {};

    headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
    });

    if (needAuth) {
      String authJwt = await Save().getAuth();
      url = (baseUrl ?? Strings.apiUrlNeedAuth) + apiAddress;
      bearer == null
          ? headers.addAll({"Authorization": "Bearer $authJwt"})
          : headers.addAll({"Authorization": bearer});
    }

    debugPrint(url);
    try {
      response = await client
          .put(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(const Duration(seconds: Strings.requestTimeOut));
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      return returnType(getError(RequestError.timeOut));
    } on Exception {
      //(e.toString());
      return returnType(getError(RequestError.noNet));
    }

    if (kDebugMode) {
      print(fullResponse != null);
    }
    if (fullResponse != null) fullResponse(response);

    String data = utf8.decode(response.bodyBytes).toString();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    // stderr.writeln(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return returnType(data);
    } else if (response.statusCode == 401) {
      return Future(() => returnType(getError(RequestError.bugFound)));
    } else {
      return Future(() => returnType(getError(RequestError.unknown)));
    }
  }

  Future fetchDataPatch(String apiAddress, Map<String, dynamic> body,
      Function(String data) returnType, Function(Response)? fullResponse,
      {bool needAuth = false,
      Map<String, String>? headers,
      String? baseUrl,
      String? bearer}) async {
    Response response;
    String url = (baseUrl ?? Strings.apiUrl) + apiAddress;
    headers = {};

    headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
    });

    if (needAuth) {
      String authJwt = await Save().getAuth();
      url = (baseUrl ?? Strings.apiUrlNeedAuth) + apiAddress;
      bearer == null
          ? headers.addAll({"Authorization": "Bearer $authJwt"})
          : headers.addAll({"Authorization": bearer});
    }

    debugPrint(url);
    try {
      response = await client
          .patch(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(const Duration(seconds: Strings.requestTimeOut));
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      return returnType(getError(RequestError.timeOut));
    } on Exception {
      //(e.toString());
      return returnType(getError(RequestError.noNet));
    }

    if (kDebugMode) {
      print(fullResponse != null);
    }
    if (fullResponse != null) fullResponse(response);

    String data = utf8.decode(response.bodyBytes).toString();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    // stderr.writeln(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return returnType(data);
    } else if (response.statusCode == 401) {
      return Future(() => returnType(getError(RequestError.bugFound)));
    } else {
      return Future(() => returnType(getError(RequestError.unknown)));
    }
  }

  Future fetchDataDelete(String apiAddress, Map<String, dynamic> body,
      Function(String data) returnType, Function(Response)? fullResponse,
      {bool needAuth = false,
      Map<String, String>? headers,
      String? baseUrl,
      String? bearer}) async {
    Response response;
    String url = (baseUrl ?? Strings.apiUrl) + apiAddress;
    headers = {};

    headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
    });

    if (needAuth) {
      String authJwt = await Save().getAuth();
      url = (baseUrl ?? Strings.apiUrlNeedAuth) + apiAddress;
      bearer == null
          ? headers.addAll({"Authorization": "Bearer $authJwt"})
          : headers.addAll({"Authorization": bearer});
    }

    debugPrint(url);
    try {
      response = await client
          .delete(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(const Duration(seconds: Strings.requestTimeOut));
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      return returnType(getError(RequestError.timeOut));
    } on Exception {
      //(e.toString());
      return returnType(getError(RequestError.noNet));
    }

    if (kDebugMode) {
      print(fullResponse != null);
    }
    if (fullResponse != null) fullResponse(response);

    String data = utf8.decode(response.bodyBytes).toString();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    // stderr.writeln(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return returnType(data);
    } else if (response.statusCode == 401) {
      return Future(() => returnType(getError(RequestError.bugFound)));
    } else {
      return Future(() => returnType(getError(RequestError.unknown)));
    }
  }

  Future fetchDataGet(String apiAddress, Function(dynamic) returnType,
      Function(Response)? fullResponse,
      {bool needAuth = false,
      Map<String, String>? headers,
      String? baseUrl,
      String? bearer}) async {
    Response response;
    String url = (baseUrl ?? Strings.apiUrl) + apiAddress;
    headers = {};

    headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
    });

    if (needAuth) {
      String authJwt = await Save().getAuth();
      url = (baseUrl ?? Strings.apiUrlNeedAuth) + apiAddress;
      bearer == null
          ? headers.addAll({"Authorization": "Bearer $authJwt"})
          : headers.addAll({"Authorization": bearer});
    }

    debugPrint(url);
    try {
      response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: Strings.requestTimeOut));
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      return returnType(getError(RequestError.timeOut));
    } on Exception {
      //(e.toString());
      return returnType(getError(RequestError.noNet));
    }

    if (kDebugMode) {
      print(fullResponse != null);
    }
    if (fullResponse != null) fullResponse(response);

    String data = utf8.decode(response.bodyBytes).toString();
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    // stderr.writeln(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return returnType(data);
    } else if (response.statusCode == 401) {
      return Future(() => returnType(getError(RequestError.bugFound)));
    } else {
      return Future(() => returnType(getError(RequestError.unknown)));
    }
  }
}
