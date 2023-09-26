import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:fx_flutterap_components/components/fx_bread_crumb/fx_app_navigator_observer.dart';
import 'package:fx_flutterap_kernel/structure/default_styles.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_config.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:crm_app/main.reflectable.dart';
import 'package:crm_app/services/routes/routes.dart';
import 'package:crm_app/utils/constants/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:reflectable/reflectable.dart';
import 'blocs/bloc_providers.dart';
import 'config/structure_change_provider.dart';
import 'config/supported_locales.dart';

import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_config.dart';

class MyReflectable extends Reflectable {
  const MyReflectable() : super(invokingCapability);
}

const myReflectable = MyReflectable();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //certificate to enable interaction with Secure End points
  loadEncryptAsset();

  //send device Id
  // await DeviceController().sendDeviceId();

  //Handling error logs
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  //initializing Flutter Logs Library
  initFlutterLogs();

  initializeReflectable();

  runApp(MyApp());
}

Future<void> loadEncryptAsset() async {
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
}

Future<void> initFlutterLogs() async {
  //Initialize Logging
  await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.SEVERE
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: ["device", "network", "errors"],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "MyLogs",
      logsExportDirectoryName: "MyLogs/Exported",
      debugFileOperations: true,
      isDebuggable: true);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    InitialStyle(context);
    InitialDims(context);
    InitialConfig();

    return MultiBlocProvider(
      providers: AppProviders.allBlocProviders,
      child: ChangeNotifierProvider<StructureChangeProvider>(
        create: (context) => StructureChangeProvider(),
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: DefaultStyles.primaryDarkColor,
              primaryColorLight: DefaultStyles.primaryLightColor,
              primaryColorDark: DefaultStyles.primaryDarkColor,
            ),
            navigatorObservers: [AppNavigatorObserver()],
            locale: Provider.of<StructureChangeProvider>(context, listen: true)
                .currentLocale,
            title: 'Kenga MIS',
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: SupportedLocales.list,
            initialRoute: AppRoutes.DEFAULT,
            routes: Routes.rout,
          ),
        ),
      ),
    );
  }
}
