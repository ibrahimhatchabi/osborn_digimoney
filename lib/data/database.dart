import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class OperationsDatabase {
  static const TRANSACTION_TABLE_NAME = "transactions";
  static const USER_TABLE_NAME = "users";
  static final OperationsDatabase _instance = OperationsDatabase._internal();

  factory OperationsDatabase() => _instance;

  static Database _db;

  OperationsDatabase._internal();

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "operation.db");

    var theDatabase = await openDatabase(path,version: 1, onCreate: _onCreate);
    return theDatabase;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE "+
      TRANSACTION_TABLE_NAME +
      " ("
      "id TEXT PRIMARY KEY, "
      "agent TEXT, "
      "date TEXT, "
      "montant TEXT, "
      "numero TEXT, "
      "status TEXT, "
      "type TEXT, "
      "creditOuCash TEXT, "
      "observations TEXT)"
    );

    await db.execute("CREATE TABLE "+
        USER_TABLE_NAME +
        " ("
        "id TEXT PRIMARY KEY, "
        "nom TEXT, "
        "prenom TEXT, "
        "telephone TEXT, "
        "shop TEXT, "
        "adresse TEXT, "
        "fonction TEXT, "
        "identifiant TEXT, "
        "password TEXT)"
    );
  }

  Future closeDB() async {
    var dbClient =  await db;
    return dbClient.close();
  }

  Future<bool> isFirstUse() async {
    var dbClient = await db;
    var res = await dbClient.query(USER_TABLE_NAME);
    return res.length > 0 ? false : true;
  }
}
