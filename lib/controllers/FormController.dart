import 'dart:math';

import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:crm_app/controllers/rest/auth_rest.dart';
import 'package:crm_app/controllers/rest/device_rest.dart';
import 'package:crm_app/utils/constants/app_constants.dart';
import 'package:sembast/sembast.dart';
import '../sembast/sembast.dart';
import '../utils/constants/collections.dart';
import 'auth_controller.dart';

class FormController {
  Future updateForms(List<dynamic> itemList, {collectionType = "form"}) async {
    try {
      await checkStoreExists(collectionType);
      final dio = Dio();
      dio.options.headers['Authorization'] =
          "Bearer ${await AuthController().getAccessToken()}";
      final client = AuthRestClient(dio);

      List<dynamic> forms = createJSONListWithIdAndLastUpdated(itemList);

      if (forms.isEmpty) {
        forms = [];
      }
      Map<String, dynamic> formsMap = {
        "data": forms,
        "collection": collectionType
      };
      final response = await client.updateForms(body: formsMap);
      return response;
    } catch (e) {
      return e;
    }
  }

  //get form data from server
  Future getFormCollectionData(Map<String, dynamic> collectionDetails) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] =
          "Bearer ${await AuthController().getAccessToken()}";
      final client = AuthRestClient(dio);
      final response = await client.getFormData(body: collectionDetails);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> asyncForms({int maxRetries = 3}) async {
    int retries = maxRetries;

    while (retries > 0) {
      try {
        final storedForms = await getFormsFromSembast();
        final response = await updateForms(storedForms);

        if (storedForms.isEmpty) {
          await storeFormItems(response['data']);
          await storeFormItems(response['permissionForEachCollection'],
              store: CollectionConstants.FORMPERMISSIONS);
          return true; // Forms successfully synced
        } else {
          if (response.containsKey("message")) {
            if (response['permissionForEachCollection'].isNotEmpty) {
              await deleteFormsCollectionFromSembast(
                  store: CollectionConstants.FORMPERMISSIONS);
              await storeFormItems(response['permissionForEachCollection'],
                  store: CollectionConstants.FORMPERMISSIONS);
            }
            return true; // Assume success for now
          } else {
            if (response['data'].isNotEmpty) {
              await updateFormFromSembast(response['data']);
            }
            if (response['permissionForEachCollection'].isNotEmpty) {
              // await deleteFormsCollectionFromSembast(
              //     store: CollectionConstants.FORMPERMISSIONS);
              await storeFormItems(response['permissionForEachCollection'],
                  store: CollectionConstants.FORMPERMISSIONS);
            }

            if (response['deleted'].isNotEmpty) {
              await deleteFormSembast(response['deleted']);
            }

            return true; // Forms successfully synced
          }
        }
      } catch (e) {
        retries--;
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    // All retries failed
    return false;
  }

  Future<bool> syncCollection(
      Map<String, dynamic> collection, int maxRetries) async {
    int retries = maxRetries; // Reset retries for each collection
    // await FormController()
    //     .updateFormStatusRandomly(collection['collectionName']);

    while (retries > 0) {
      try {
        final body = await FormController()
            .generateCollectionBody(collection['collectionName']);

        final formData = await FormController().getFormCollectionData(body);

        print("========Return back================================");
        // print(formData);
        print("========Return back================================");

        if (formData.containsKey("messageUpToDate")) {
        } else if (formData.containsKey('allData')) {
          await FormController().deleteFormsCollectionFromSembast(
              store: collection['collectionName']);
          List<dynamic> allData = formData['allData'];
          await FormController()
              .storeFormItems(allData, store: collection['collectionName']);
        } else {
          // if (formData.containsKey("mobileDeletedData") &&
          //     formData['mobileDeletedData'].isNotEmpty) {
          //   //delete the documents
          //   await FormController().deleteFormSembast(
          //       formData['mobileDeletedData'],
          //       store: collection['collectionName']);
          // }
          // if (formData.containsKey("mobileNewData")) {
          //   await FormController().updateFormFromSembast(
          //       formData['mobileUpdatedData'],
          //       store: collection['collectionName']);
          // }

          // if (formData.containsKey("mobileUpdatedData")) {
          //   //update the documents
          //   await FormController().updateFormFromSembast(
          //       formData['mobileUpdatedData'],
          //       store: collection['collectionName']);
          // }
          // if (formData.containsKey("statusUpdatedFromServer")) {
          //   await updateFormFromSembast(formData['serverUpdatedData'],
          //       store: collection['collectionName']);
          // } else if (formData.containsKey("statusDeletedFromServer")) {
          //   await FormController().deleteFormSembast(
          //       formData['serverDeletedData'],
          //       store: collection['collectionName']);
          // } else if (formData.containsKey("statusNewFromServer")) {
          //   await FormController().insertFormIntoSembast(
          //       formData['serverNewData'],
          //       store: collection['collectionName']);
          // } else {
          //   // print("Unhandled status case");
          // }
        }
        return true;
      } catch (e) {
        print("=========Retrying Now===================================");
        print(e.toString());
        print("=========Retrying Now===================================");
        retries--;
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    return false;
  }

  Future<List<Map<String, dynamic>>> fetchAndGenerateCollections() async {
    final forms = await FormController().getFormsFromSembast();
    final allCollections =
        await FormController().getCollectionNameFromForms(forms);
    return allCollections;
  }

  Future collectionForms({collectionType = "form"}) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] =
          "Bearer ${await AuthController().getAccessToken()}";
      final client = AuthRestClient(dio);

      Map<String, dynamic> formsMap = {
        "data": [],
        "collection": collectionType
      };
      final response = await client.updateForms(body: formsMap);
      return response;
    } catch (e) {
      return e;
    }
  }

  List<Map<String, dynamic>> createJSONListWithIdAndLastUpdated(
      List<dynamic> forms) {
    if (forms.isEmpty) {
      return [];
    }
    return forms.map((form) {
      dynamic lastUpdatedValue;

      // Check if 'lastUpdated' is in 'metaData'
      if (form['metaData'] != null && form['metaData']['lastUpdated'] != null) {
        lastUpdatedValue = form['metaData']['lastUpdated'];
      }
      // Check if 'lastUpdated' is in the main document
      else if (form['lastUpdated'] != null) {
        lastUpdatedValue = form['lastUpdated'];
      }
      // Check if 'lastUpdated' is in 'meta' document
      else if (form['meta'] != null && form['meta']['lastUpdated'] != null) {
        lastUpdatedValue = form['meta']['lastUpdated'];
      }

      return {
        'id': form['_id'],
        'lastUpdated': lastUpdatedValue,
      };
    }).toList();
  }

  List<Map<String, dynamic>> getCollectionNameFromForms(List<dynamic> forms) {
    return forms.map((form) {
      return {
        'collectionName': form['collectionName'],
      };
    }).toList();
  }

  //get a specific collection from sembast
  Future<List<Map<String, dynamic>>> getSpecificollectionDetailsFromSembast(
      String collectionName,
      {String store = CollectionConstants.FORMS}) async {
    final StoreRef<int, Map<String, dynamic>> formStore =
        intMapStoreFactory.store(store);
    final db = await SembastService.database;
    final finder =
        Finder(filter: Filter.matches("collectionName", collectionName));
    final collectionDetails = await formStore.find(db, finder: finder);
    final collectionDetailsList =
        collectionDetails.map((form) => form.value).toList();
    return collectionDetailsList;
  }

  //get all document for a specific collection where status matches UPDATED
  Future<List<dynamic>> getCollectionFromSembast(
      String collectionName, String status) async {
    try {
      await checkStoreExists(collectionName);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      final finder = Finder(filter: Filter.matches("mobileStatus", status));
      final formMaps = await formStore.find(db, finder: finder);
      final formMapsList = formMaps.map((form) => form.value).toList();
      return formMapsList;
    } catch (e) {
      rethrow;
    }
  }

  //update the status of a document in a collection
  Future<void> updateCollectionStatus(
      String collectionName, String status) async {
    try {
      // await checkStoreExists(collectionName);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      final finder = Finder(filter: Filter.matches("mobileStatus", status));
      final formMaps = await formStore.find(db, finder: finder);
      final formMapsList = formMaps.map((form) => form.value).toList();
      if (status == AppConstants.DELETED) {
        //delete the documents
        for (var form in formMapsList) {
          var finder = Finder(filter: Filter.matches("_id", form['_id']));
          await formStore.delete(db, finder: finder);
        }
      }

      for (var form in formMapsList) {
        var finder = Finder(filter: Filter.matches("_id", form['_id']));
        await formStore.update(db, {'mobileStatus': AppConstants.SYNCED},
            finder: finder);
      }
    } catch (e) {
      rethrow;
    }
  }

  //first order the documents in a collection by lastUpdated and get the last updated date
  Future<String?> getCollectionFromSembastByLastUpdated(
      String collectionName) async {
    try {
      await checkStoreExists(collectionName);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      final finder = Finder(sortOrders: [SortOrder("lastUpdated", false)]);
      final formMaps = await formStore.find(db, finder: finder);
      final formMapsList = formMaps.map((form) => form.value).toList();
      if (formMapsList.isEmpty) {
        return null; // Return null to indicate no last updated date
      }

      // Get the last updated date
      final lastUpdated = formMapsList[0]['lastUpdated'];
      return lastUpdated;
    } catch (e) {
      rethrow;
    }
  }

  //generate a response to send to the server
  Future<Map<String, dynamic>> generateCollectionBody(
      String collectionName) async {
    try {
      final allStoredCollections =
          await getFormsFromSembast(store: collectionName);

      if (allStoredCollections.isEmpty) {
        return {
          "formDataNew": [],
          "formDataDeleted": [],
          "formDataUpdated": [],
          "collectionName": collectionName,
          "collectionSize": 0,
          "date": null,
          "mobileStatusNew": null,
          "mobileStatusUpdated": null,
          "mobileStatusDeleted": null,
        };
      }

      final newCollections = <dynamic>[];
      final updatedCollections = <dynamic>[];
      final deletedCollections = <dynamic>[];

      for (var storedCollection in allStoredCollections) {
        final status = storedCollection['mobileStatus'];
        if (status == AppConstants.NEW) {
          newCollections.add(storedCollection);
        } else if (status == AppConstants.UPDATED) {
          updatedCollections.add(storedCollection);
        } else if (status == AppConstants.DELETED) {
          deletedCollections.add(storedCollection);
        }
      }

      return {
        "formDataNew": [],
        "formDataUpdated": updatedCollections,
        "formDataDeleted": deletedCollections,
        //"formDataUpdated": [],
        //"formDataDeleted": [],
        "collectionName": collectionName,
        "collectionSize": allStoredCollections.length,
        "date": await getCollectionFromSembastByLastUpdated(collectionName),
        //"mobileStatusNew": newCollections.isNotEmpty ? AppConstants.NEW : null,
        "mobileStatusUpdated":
            updatedCollections.isNotEmpty ? AppConstants.UPDATED : null,
        "mobileStatusDeleted":
            deletedCollections.isNotEmpty ? AppConstants.DELETED : null,
        "mobileStatusNew": null,
        // "mobileStatusUpdated": null,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeFormItems(List<dynamic> formItems,
      {String store = CollectionConstants.FORMS}) async {
    try {
      await checkStoreExists(store);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      final formMaps = formItems.cast<Map<String, dynamic>>();
      await formStore.addAll(db, formMaps);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getFormsFromSembast(
      {String store = CollectionConstants.FORMS}) async {
    try {
      await checkStoreExists(store);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      final formMaps = await formStore.find(db);
      final formMapsList = formMaps.map((form) => form.value).toList();
      return formMapsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkStoreExists(String store) async {
    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      // Check if the store is empty or doesn't exist
      if (await formStore.count(db) == 0) {
        await formStore.addAll(db, []);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  //get store by name from sembast
  Future<List<Map<String, dynamic>>> getStoreFromSembast(String store) async {
    try {
      await checkStoreExists(store);

      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      final formMaps = await formStore.find(db);
      final formMapsList = formMaps.map((form) => form.value).toList();
      return formMapsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFormsCollectionFromSembast(
      {String store = CollectionConstants.FORMS}) async {
    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      await formStore.delete(db);
      print("Deleted");
    } catch (e) {
      rethrow;
    }
  }

  //update forms with specific id
  Future<void> updateFormFromSembast(List<dynamic> forms,
      {String store = CollectionConstants.FORMS}) async {
    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      final formMaps = forms.cast<Map<String, dynamic>>();
      for (var form in formMaps) {
        var finder = Finder(filter: Filter.matches("_id", form['_id']));
        // Fetch the existing form data
        var existingForm = await formStore.findFirst(db, finder: finder);
        if (existingForm != null) {
          // Update only the status and lastUpdated fields
          await formStore.update(
              db,
              {
                'mobileStatus': AppConstants.SYNCED,
                'lastUpdate': form['lastUpdated']
              },
              finder: finder);
        } else {
          // If the form doesn't exist, add it
          await formStore.add(db, form);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //insert a  list of forms into a collection
  Future<void> insertFormIntoSembast(List<dynamic> forms,
      {String store = CollectionConstants.FORMS}) async {
    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      final formMaps = forms.cast<Map<String, dynamic>>();
      await formStore.addAll(db, formMaps);
    } catch (e) {
      rethrow;
    }
  }

  //update the status of a document in a collection
  Future<void> updateFormStatus(
      String collectionName, String status, String id) async {
    try {
      // await checkStoreExists(collectionName);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      final finder = Finder(filter: Filter.matches("_id", id));
      final formMaps = await formStore.find(db, finder: finder);
      final formMapsList = formMaps.map((form) => form.value).toList();
      if (status == AppConstants.DELETED) {
        //delete the documents
        for (var form in formMapsList) {
          var finder = Finder(filter: Filter.matches("_id", form['_id']));
          await formStore.delete(db, finder: finder);
        }
      }

      for (var form in formMapsList) {
        var finder = Finder(filter: Filter.matches("_id", form['_id']));
        await formStore.update(db, {'mobileStatus': AppConstants.SYNCED},
            finder: finder);
      }
    } catch (e) {
      rethrow;
    }
  }
  //update the status of a document in a collection

  //update the status of a documents in a collection when list of ids are provided
  Future<void> updateFormStatusWithIds(
      String collectionName, String status, List<dynamic> ids) async {
    try {
      // await checkStoreExists(collectionName);
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      // final idMaps = ids.cast();
      for (var id in ids) {
        var finder = Finder(filter: Filter.matches("_id", id));
        await formStore.update(db, {'mobileStatus': status}, finder: finder);
      }
    } catch (e) {
      rethrow;
    }
  }

  //create a dummy function that will be used to through through all the collections and randomly update the status of each document
  Future<void> updateFormStatusRandomly(String collectionName) async {
    List<String> status = [
      AppConstants.NEW,
      AppConstants.UPDATED,
      AppConstants.DELETED
    ];
    final random = Random(); // Create a random number generator
    int updatedCount = 0; // Counter for updated records

    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(collectionName);
      final db = await SembastService.database;
      final formMaps = await formStore.find(db);
      final formMapsList = formMaps.map((form) => form.value).toList();

      for (var form in formMapsList) {
        if (updatedCount >= 10) {
          // Stop updating after the first 10 records
          break;
        }

        var finder = Finder(filter: Filter.matches("_id", form['_id']));
        // Generate a random index to select a status from the list
        int randomIndex = random.nextInt(status.length);
        // Update the status randomly
        await formStore.update(db, {'mobileStatus': status[randomIndex]},
            finder: finder);

        updatedCount++; // Increment the counter for updated records
      }

      print("Updated");
    } catch (e) {
      rethrow;
    }
  }

  //delete forms with specific id
  Future<void> deleteFormSembast(List<dynamic> ids,
      {String store = CollectionConstants.FORMS}) async {
    try {
      final StoreRef<int, Map<String, dynamic>> formStore =
          intMapStoreFactory.store(store);
      final db = await SembastService.database;
      // final idMaps = ids.cast();
      for (var id in ids) {
        var finder = Finder(filter: Filter.matches("_id", id));
        await formStore.delete(db, finder: finder);
      }
    } catch (e) {
      rethrow;
    }
  }
}
