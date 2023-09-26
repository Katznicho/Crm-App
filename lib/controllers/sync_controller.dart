import 'package:dio/dio.dart';
import 'package:crm_app/controllers/FormController.dart';
import 'package:crm_app/controllers/device_controller.dart';
import 'package:sembast/sembast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
// import 'package:crm_app/controllers/rest/sync_rest.dart';

import '../sembast/sembast.dart';
import 'auth_controller.dart';
import 'menu_controller.dart';

class SynController {
  Future sendUserDetails() async {
    try {
      // Make  a post request
      final dio = Dio();
      dio.options.headers['Authorization'] =
          "Bearer ${await AuthController().getAccessToken()}";

      final Map<String, dynamic> decodedTokenDetails = AuthController()
          .decodeAccessToken(await AuthController().getAccessToken());
      String userName = decodedTokenDetails['preferred_username'];
      String deviceId = await DeviceController().getDeviceId();

      Map<String, dynamic> syncDetails = {
        "device_Id": deviceId,
        "userName": userName,
      };

      // final client = SyncRestClient(dio);
      // final response = await client.addUser(body: syncDetails);

      // return response;
    } catch (e) {
      return e;
    }
  }

  Future<void> storeReport(Map<String, dynamic> report,
      {String reportStore = "syncReport"}) async {
    try {
      FormController().checkStoreExists(reportStore);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(reportStore);
      final db = await SembastService.database;
      await formStore.add(db, report);
      final allReports = await formStore.find(db);
    } catch (e) {}
  }

  //get all sync reports
  Future<List<Map<String, dynamic>>> getSyncReports(
      {String reportStore = "syncReport"}) async {
    try {
      FormController().checkStoreExists(reportStore);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(reportStore);
      final db = await SembastService.database;
      final formMaps = await formStore.find(db);
      final formMapsList = formMaps.map((form) => form.value).toList();
      return formMapsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> startSyncProcess(ProgressDialog pd, {int maxRetries = 3}) async {
    final allCollections = await FormController().fetchAndGenerateCollections();

    final totalSteps = allCollections.length;
    int currentStep = 0;
    int syncedCount = 0;
    int failedCount = 0;
    int totalCollections = 0;
    List<String> failedCollections = [];
    bool menuSynced = await MenuItemController().asyncMenu();
    bool formsSynced = await FormController().asyncForms();

    for (var collection in allCollections) {
      totalCollections++;
      try {
        bool collectionSynced =
            await FormController().syncCollection(collection, maxRetries);
        if (collectionSynced) {
          syncedCount++;
        } else {
          failedCount++;
          failedCollections.add(collection['collectionName']);
        }
        // await FormController()
        //     .updateFormStatusRandomly(collection['collectionName']);
      } catch (e) {
        // failedCount++;
        // failedCollections.add(collection['collectionName']);
      }
      currentStep++;
      final progressPercentage = (currentStep / totalSteps) * 100;
      pd.update(value: progressPercentage.toInt(), msg: "Syncing...");
    }

    Map<String, dynamic> syncDetails = {
      "synced": syncedCount,
      "failed": failedCount,
      "failedCollections": failedCollections,
      "date": DateTime.now().toString(),
      "totalCollections": totalCollections,
      "menuSynced": menuSynced,
      "formsSynced": formsSynced,
    };

    await storeReport(syncDetails);

    print("Synced: $syncDetails");
  }
}
