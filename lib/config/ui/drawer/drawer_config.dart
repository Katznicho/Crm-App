import "package:flutter/material.dart";
import 'package:fx_flutterap_components/ui/fx_drawer/fx_drawer.dart';
import '../../../utils/constants/app_routes.dart';

class DrawerConfig extends StatefulWidget {
  const DrawerConfig({Key? key}) : super(key: key);

  @override
  State<DrawerConfig> createState() => _DrawerConfigState();
}

class _DrawerConfigState extends State<DrawerConfig> {
  //const _DrawerConfigState({Key? key}) : super(key: key);
  List menu(BuildContext context) {
    return [
      {
        'title': "Home",
        'iconPath': "packages/fx_flutterap_components/assets/svgs/home.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [],
      },
      {
        'title': "Sales",
        'iconPath':
            "packages/fx_flutterap_components/assets/svgs/bookmarks.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [
          {
            'title': "Visit Shop",
            'iconPath': "",
            'routeName': AppRoutes.HOME,
            'isReturnable': false,
            'submenu': [],
          },
          {
            'title': "View History",
            'iconPath': "",
            'routeName': AppRoutes.HOME,
            'isReturnable': false,
            'submenu': [],
          },
        ],
      },
      {
        'title': "Orders",
        'iconPath':
            "packages/fx_flutterap_components/assets/svgs/bookmarks.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [
          {
            'title': "Create Order",
            'iconPath': "",
            'routeName': AppRoutes.HOME,
            'isReturnable': false,
            'submenu': [],
          },
          {
            'title': "View Orders",
            'iconPath': "",
            'routeName': AppRoutes.HOME,
            'isReturnable': false,
            'submenu': [],
          },
        ],
      },
      {
        'title': "Tasks",
        'iconPath': "packages/fx_flutterap_components/assets/svgs/refresh.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [
          {
            'title': "View Tasks",
            'iconPath': "",
            'routeName': AppRoutes.HOME,
            'isReturnable': false,
            'submenu': [],
          },
        ],
      },
      {
        'title': "Tickets",
        'iconPath':
            "packages/fx_flutterap_components/assets/svgs/bookmarks.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [
          {
            'title': "View Tickets",
            'iconPath': "",
            'routeName': AppRoutes.VIEWTICKETS,
            'isReturnable': false,
            'submenu': [],
          },
        ],
      },
      {
        'title': "Market",
        'iconPath': "packages/fx_flutterap_components/assets/svgs/layer.svg",
        'routeName': AppRoutes.HOME,
        'isReturnable': false,
        'submenu': [],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FxDrawer(menu(context));
  }
}
