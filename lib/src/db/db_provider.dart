
/*
 * Database 
 * Function: database creation and configuration
 */

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './db_tables.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async{

    // path where the database will be stored
    Directory directory = await getApplicationDocumentsDirectory();
    final path = '${ directory.path }/Todos.db';

    //create database
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db)async{
        await db.execute( DBTables.todoTable );

      },
      onCreate: ( Database db, int version )async{
        await db.execute( DBTables.todoTable );
      }
    );
  }

  
}