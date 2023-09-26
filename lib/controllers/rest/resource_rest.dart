import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../utils/constants/app_endpoints.dart';

part 'resource_rest.g.dart';

@RestApi(
    baseUrl: AppEndpoints.baseUrl,
    parser: Parser.FlutterCompute,
)
abstract class ResourceRestClient {
  factory ResourceRestClient(Dio dio, {String? baseUrl}) {
    dio.options.headers['content-Type'] = 'application/json';
    return _ResourceRestClient(dio, baseUrl: baseUrl);
  }

  @GET(AppEndpoints.resourcesEndPoint)
  Future<dynamic> getAllResources();
}
