import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import 'package:crm_app/controllers/rest/auth_rest.dart';

import '../../utils/constants/app_endpoints.dart';

part 'types_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class TypesRestClient {
  factory TypesRestClient(Dio dio, {String? baseUrl}) {
    return _TypesRestClient(dio, baseUrl: baseUrl);
  }

  @GET(AppEndpoints.typesEndPoint)
  Future<dynamic> getAllTypes();
}
