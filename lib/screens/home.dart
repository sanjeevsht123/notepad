import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/Models/NoteModel.dart';
import 'package:notepad/screens/note_details.dart';
import 'package:notepad/utils/dbState.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notepad",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: const NoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetails(
                  "Add", NoteModel(content: "", title: "", date: ""))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteList extends ConsumerStatefulWidget {
  const NoteList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends ConsumerState<NoteList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(dbStateProvider).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final dbData = ref.watch(dbStateProvider);
    if (dbData.notes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 7,
        ),
        itemCount: dbData.notes.length,
        itemBuilder: (context, index) {
          final note = dbData.notes[index];
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(13, 15, 13, 5),
              // height: double.infinity,
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, -2),
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 1,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    note.content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      note.date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => NoteDetails('Edit', note)));
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(dbStateProvider).deleteNotes(note.id);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
