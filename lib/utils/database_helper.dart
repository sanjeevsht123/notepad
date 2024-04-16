import 'package:flutter/material.dart';
import 'package:notepad/Models/NoteModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static late Database _database;
  static late DatabaseHelper _databaseHelper;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}notepad.db';
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }

  String noteTable = 'noteTable';
  String id = 'id';
  String title = 'title';
  String content = 'content';
  String date = 'date';

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($id INTEGER PRIMARY KEY AUTOINCREMENT,$title TEXT,$content TEXT,$date TEXT)');
  }

  Future<int> insertData(NoteModel notes) async {
    Database db = await database;
    var insert = await db.insert(noteTable, notes.toMap());
    return insert;
  }

  Future<List<NoteModel>> fetchData() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(noteTable);
    return List.generate(
      maps.length,
      (i) => NoteModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        date: maps[i]['date'],
      ),
    );
  }

  Future<int> updateData(NoteModel notes) async {
    Database db = await database;
    var update = await db
        .update(noteTable, notes.toMap(), where: 'id=?', whereArgs: [notes.id]);
    return update;
  }

  Future<int> deleteData(int id) async {
    Database db = await database;
    var delete = await db.delete(noteTable, where: 'id:?', whereArgs: [id]);
    return delete;
  }
}
