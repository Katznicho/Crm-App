import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController {
  Future<bool> getInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return [
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.other,
    ].contains(connectivityResult);
  }
}
