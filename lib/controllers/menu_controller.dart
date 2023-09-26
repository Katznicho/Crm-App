import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:crm_app/controllers/rest/auth_rest.dart';
import 'package:crm_app/controllers/rest/device_rest.dart';
import 'package:crm_app/utils/constants/collections.dart';
import 'package:sembast/sembast.dart';

import '../sembast/sembast.dart';
import '../utils/constants/app_routes.dart';
import 'auth_controller.dart';

class MenuItemController {
  //receive menu from server
  Future receiveMenu() async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] =
          "Bearer ${await AuthController().getAccessToken()}";

      final client = AuthRestClient(dio);
      var menuItems = await retrieveMenuItems();

      if (menuItems.isEmpty) {
        menuItems = [];
      }
      Map<String, dynamic> menu = {"list": menuItems};

      final response = await client.getMenu(body: menu);

      return response;
    } catch (e) {
      print("========Receive Menu======================");
      print(e);
      print("=========Receive Menu=======================");
      return [];
    }
  }

  Future<bool> asyncMenu({int maxRetries = 3}) async {
    int retries = maxRetries;

    while (retries > 0) {
      try {
        final menu = await receiveMenu();
        if (menu.containsKey("message")) {
          // Handle the message case
          return true; // Assume success for now
        } else {
          await updateMenuItems(menu['data']);
          return true; // Menu successfully synced
        }
      } catch (e) {
        print("Error Getting Mdenu");
        print(e);
        print("Error Getting Menu");
        retries--;
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    // All retries failed
    return false;
  }

  List<Map<String, dynamic>> convertMenuToData(List<dynamic> menuList,
      {bool generateSidebarMenu = false}) {
    String titleOrLabel = generateSidebarMenu ? "title" : "label";
    String submenuOrSubMenu = generateSidebarMenu ? "submenu" : "subMenu";
    String routerNameOrRouterLink =
        generateSidebarMenu ? "routeName" : "routerLink";
    return menuList.map((m) {
      String iconName = "form.svg";
      switch (m['label']) {
        case "Logout":
          iconName = "SignOut.svg";
          break;
        case "Settings":
          iconName = "setting2.svg";
          break;
        case "Mobile Data":
          iconName = "refresh.svg";
          break;
        case "Users":
          iconName = "profilecircle.svg";
        case "Tags":
          iconName = "bookmarks.svg";
        default:
          break;
      }

      return {
        'id': m["id"],
        'iconPath': generateSidebarMenu
            ? "packages/fx_flutterap_components/assets/svgs/$iconName"
            : m["iconPath"],
        'label': m["label"],
        titleOrLabel: m["label"],
        'type': m["type"],
        'isReturnable': false,
        submenuOrSubMenu: mapSubMenuToData(m["subMenu"],
            generateSidebarMenu: generateSidebarMenu),
        routerNameOrRouterLink: generateSidebarMenu ? "" : m["routerLink"],
      };
    }).toList();
  }

  List<Map<String, dynamic>> mapSubMenuToData(List<dynamic>? subMenuList,
      {required bool generateSidebarMenu}) {
    if (subMenuList == null) {
      return [];
    }
    return subMenuList.map((sub) {
      // String titleOrLabel = generateSidebarMenu ? "title" : "label";
      String routerNameOrRouterLink =
          generateSidebarMenu ? "routeName" : "routerLink";

      if (sub['label'] == null || sub['routerLink'] == null) {}

      return {
        // 'iconPath': "packages/fx_flutterap_components/assets/svgs/SignOut.svg",
        'iconPath': null,
        // 'id': sub.subMenuItemId,
        // titleOrLabel: sub["label"],
        "title": sub["label"] ?? "null",
        //"type": "link",
        'type': sub["type"],
        'collectionName': extractCollectionName(sub["routerLink"][0]),
        'isReturnable': true,
        routerNameOrRouterLink: AppRoutes.ONE ?? AppRoutes.HOME,
        'submenu': []
      };
    }).toList();
  }

  String extractCollectionName(String routerLink) {
    final parts = routerLink.split('/');

    if (parts.length >= 4) {
      return parts[3];
    } else {
      return ''; // or some default value, or throw an error
    }
  }

  //store menu into sem
  Future<void> storeMenuItems(List<dynamic> menuItems) async {
    try {
      final StoreRef<int, Map<String, dynamic>> menuStore =
          intMapStoreFactory.store(CollectionConstants.MENU);
      final db = await SembastService.database;
      final menuMaps = menuItems.cast<Map<String, dynamic>>();
      await menuStore.addAll(db, menuMaps);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> retrieveMenuItems(
      {generateSideBar = false}) async {
    try {
      final StoreRef<int, Map<String, dynamic>> menuStore =
          intMapStoreFactory.store(CollectionConstants.MENU);
      final db = await SembastService.database;

      final records = await menuStore.find(db);
      final menuMaps = records.map((record) => record.value).toList();

      if (generateSideBar) {
        final menu = convertMenuToData(menuMaps, generateSidebarMenu: true);
        return menu;
      } else {
        return menuMaps;
      }
    } catch (e) {
      rethrow;
    }
  }

  //update menu by deleting all and inserting new
  Future<void> updateMenuItems(List<dynamic> menuItems) async {
    try {
      final StoreRef<int, Map<String, dynamic>> menuStore =
          intMapStoreFactory.store(CollectionConstants.MENU);
      final db = await SembastService.database;
      await menuStore.delete(db);
      final menuMaps = menuItems.cast<Map<String, dynamic>>();
      await menuStore.addAll(db, menuMaps);
    } catch (e) {
      rethrow;
    }
  }
}
