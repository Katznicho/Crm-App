import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastService {
  static DatabaseFactory _dbFactory = databaseFactoryWeb;
  static Database? _databaseInstance;
  

  static Future<Database> get database async {
    _databaseInstance ??= await _dbFactory.openDatabase('kenga_mis.db');
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
    if (_databaseInstance != null) {
      await _databaseInstance!.close();
      _databaseInstance = null;
    }
  }
}
