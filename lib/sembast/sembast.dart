import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

// ...

class SembastService {
  static late DatabaseFactory _dbFactory;
  static Database? _databaseInstance;

  static Future<Database> get database async {
    if (_databaseInstance != null) {
      return _databaseInstance!;
    }

    const dbName = 'kenga_mis.db';

    if (kIsWeb) {
      _dbFactory = databaseFactoryWeb;
      _databaseInstance = await _dbFactory.openDatabase(dbName);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = '${dir.path}/$dbName';
      _dbFactory = databaseFactoryIo;
      _databaseInstance = await _dbFactory.openDatabase(dbPath);
    }

    return _databaseInstance!;
  }

  // Private constructor to prevent direct instantiation.
  SembastService._();

  // Close db
  Future<void> closeDatabase() async {
    final db = await SembastService.database;
    await db.close();
  }

  // Clear db
  static Future<void> clearDatabase() async {
    //final db = await SembastService.database;
    //await db.close();
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/kenga_mis.db';
    await databaseFactoryIo.deleteDatabase(dbPath);

    // if (kIsWeb) {
    //   final dir = await getApplicationDocumentsDirectory();
    //   final dbPath = '${dir.path}/kenga_mis.db';
    //   await databaseFactoryIo.deleteDatabase(dbPath);
    // } else {
    //   await databaseFactoryWeb.deleteDatabase('kenga_mis.db');
    // }
  }
}

// https://demo.crvpfmis.net/gateway/api/v1/mobile-sync/getFormData
