import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../utils/constants/app_endpoints.dart';

part 'device_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class DeviceRestClient {
  factory DeviceRestClient(Dio dio, {String baseUrl}) = _DeviceRestClient;

  //send device id
  @POST(AppEndpoints.sendDeviceId)
  Future<dynamic> sendDeviceId({@Body() required Map<String, String> body});


}
