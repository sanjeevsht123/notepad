import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/Models/NoteModel.dart';
import 'package:notepad/utils/database_helper.dart';

// final dbProvider = Provider((ref) => DatabaseHelper());

class DbSataeManagement extends ChangeNotifier {
  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  DatabaseHelper dbhelper = DatabaseHelper();
  Future<void> fetchData() async {
    _notes = await dbhelper.fetchData();
    notifyListeners();
  }

  Future<void> addNotes(NoteModel note) async {
    await dbhelper.insertData(note);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> updateNotes(NoteModel note) async {
    await dbhelper.updateData(note);
    int index = _notes.indexWhere((element) => element.id == note.id);
    _notes[index] = note;
    notifyListeners();
  }

  Future<void> deleteNotes(int id) async {
    await dbhelper.deleteData(id);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  // Future<int?> getCount() async {
  //   // Change the return type to Future<int?>
  //   await fetchData();
  //   return await dbhelper.getNoteCount(); // Return the count directly
  // }
}

final dbStateProvider = ChangeNotifierProvider((ref) => DbSataeManagement());
