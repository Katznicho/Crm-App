import 'package:dio/dio.dart';
import 'package:crm_app/utils/constants/app_endpoints.dart';
import 'package:retrofit/http.dart';

part 'collections_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class CollectionRestClient {
  factory CollectionRestClient(Dio dio, {String? baseUrl}) {
    dio.options.headers['content-Type'] = 'application/json';
    return _CollectionRestClient(dio, baseUrl: baseUrl);
  }

  //get all collections
  @GET(AppEndpoints.allCollections)
  Future<dynamic> allCollections();

  //get a specific collection
  @GET("${AppEndpoints.getSpecificCollections}/{collectionName}")
  Future<dynamic> getSpecificCollection(
      @Path("collectionName") String collectionName);
}
