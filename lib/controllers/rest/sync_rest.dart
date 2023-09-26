import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../utils/constants/app_endpoints.dart';

part 'sync_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class SyncRestClient {
  factory SyncRestClient(Dio dio, {String baseUrl}) = _SyncRestClient;

  // @POST(AppEndpoints.addUser)
  // Future<dynamic> addUser({@Body() required Map<String, dynamic> body});
}
