import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteDetails extends ConsumerWidget {
  const NoteDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController title = TextEditingController(text: '');
    TextEditingController contain = TextEditingController(text: '');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Notes"),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: contain,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Notes',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9))),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
