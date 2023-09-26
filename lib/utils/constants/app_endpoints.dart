// api_constants.dart

class AppEndpoints {
  static const String baseUrl = "https://demo.crvpfmis.net/gateway/api/v1";
  // static const String localBaseURL =
  //     "https://a63f-41-210-145-17.ngrok.io/api/v1";
  static const String localBaseURL = "https://demo.crvpfmis.net/gateway/api/v1";
  static const String loginEndPoint = "/user/login";
  static const String resourcesEndPoint = "/resources";
  static const String typesEndPoint = "/type";
  static const String logout = "/user/logout";
  static const String getSpecificCollections = "/data";
  static const String allCollections = "/collections";
  static const String menu = "/resources/menu";

  //device
  static const String sendDeviceId = "/mobile/devices";
  static const String sendResources = "/monitor-collections/collections";

  //menu
  static const String getMenu = "/mobile-sync/sendMenu";
  //forms

  static const String updateForms = "/mobile-sync/sendForms";
  static const String getFormData  = "/mobile-sync/getFormData";

  static const int timeout =
      30; // Increase or decrease as per your requirement.
  static String refreshToken = 'refresh_token';
  static String keyForJWTToken = 'accessToken';
}
