import 'package:flutter/material.dart';
import 'package:fx_flutterap_kernel/structure/global_variables.dart';
import 'package:crm_app/screens/AuthNavigator.dart';

import '../../app/local/shared_preferences/save.dart';
import '../../screens/signin.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InitialPage();
  }
}

class _InitialPage extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _getIsNightMode();
  }

  @override
  Widget build(BuildContext context) {
    return const AuthNavigator();
  }

  Future<bool> _getIsNightMode() async {
    String nightMode0 = await Save().getMode();

    setState(() {
      nightMode = nightMode0 == "night" ? true : false;
    });

    return nightMode;
  }
}
