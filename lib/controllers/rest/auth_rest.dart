import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../utils/constants/app_endpoints.dart';

part 'auth_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST(AppEndpoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  //logout
  @POST("${AppEndpoints.logout}/{userId}")
  Future<dynamic> signOut(@Path("userId") String userId);

  //send device id
  @POST(AppEndpoints.sendDeviceId)
  Future<dynamic> sendDeviceId({@Body() required Map<String, String> body});

  //get all collections
  @GET(AppEndpoints.allCollections)
  Future<dynamic> allCollections();

  //get a specific collection
  @GET("${AppEndpoints.getSpecificCollections}/{collectionName}")
  Future<dynamic> getSpecificCollection(
      @Path("collectionName") String collectionName);

  @GET(AppEndpoints.resourcesEndPoint)
  Future<dynamic> getAllResources();

  @GET(AppEndpoints.typesEndPoint)
  Future<dynamic> getAllTypes();

  @POST(AppEndpoints.getMenu)
  Future<dynamic> getMenu({@Body() required Map<String, dynamic> body});

  @POST(AppEndpoints.updateForms)
  Future<dynamic> updateForms({@Body() required Map<String, dynamic> body});

  @POST(AppEndpoints.getFormData)
  Future<dynamic> getFormData({@Body() required Map<String, dynamic> body});
}
