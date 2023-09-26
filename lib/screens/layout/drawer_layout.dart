// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fx_flutterap_template/default_template/drawer_style/drawer_style.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_builder.dart';

import '../../config/ui/drawer/drawer_config.dart';

class DrawerLayout extends StatelessWidget {
  final Widget child;

  const DrawerLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StructureBuilder(
      drawer: DrawerStyle(
          adminPanelTitle: AppLocalizations.of(context)!.adminpaneltitle,
          fullName: AppLocalizations.of(context)!.fullname,
          drawerItems: DrawerConfig()),
      child: child,
    );
  }
}
