import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDbHelper {
  static var _instance;

  HistoryDbHelper._internal();

  static HistoryDbHelper getInstance() {
    if (_instance == null) {
      _instance = HistoryDbHelper._internal();
    }
    return _instance;
  }

  var historyDb;
  final String _dbName = 'history';
  final String _seachKey = 'name';

  void openDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'history.db');
    await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_dbName (id INTEGER PRIMARY KEY autoincrement, $_seachKey TEXT not null)');
    }).then((db) {
      historyDb = db;
    });
  }

  insertToHistryDb(String value) async =>
      await historyDb?.insert(_dbName, {_seachKey: value});

  clearContent_DB() async => await historyDb?.execute('DELETE FROM $_dbName');

  void closeDb() async {
    await historyDb?.close();
  }

  void delDataBase() async {
    String databasesPath = await getDatabasesPath();
    String path = databasesPath + '/history.db';
    deleteDatabase(path);
  }

  Future<List<String>> queryHistry() async {
    List<Map<String, dynamic?>>? historiesDb =
        await historyDb?.query(_dbName, distinct: true, limit: 8);
    List<String> histories = [];
    for (var history in historiesDb!) {
      histories.add(history[_seachKey]);
    }
    return histories;
  }
}
