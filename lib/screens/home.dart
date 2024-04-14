import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/screens/note_details.dart';

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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NoteDetails()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteList extends ConsumerWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 7,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(13, 15, 13, 5),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
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
          child: const Column(
            children: [
              Text(
                "Title",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "This is the test note for this project.Please ensure that it works as expected",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "2024/04/14",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
