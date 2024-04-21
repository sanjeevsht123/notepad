import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/Models/NoteModel.dart';
import 'package:notepad/utils/dbState.dart';
import 'package:intl/intl.dart';

class NoteDetails extends ConsumerWidget {
  final String mainTitle;
  final NoteModel notes;
  const NoteDetails(this.mainTitle, this.notes, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController =
        TextEditingController(text: notes.title);
    TextEditingController containController =
        TextEditingController(text: notes.content);
    formateDate() {
      DateTime now = DateTime.now();
      String formatedDate = DateFormat('yyyy-MM-dd').format(now);
      return formatedDate;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$mainTitle Notes"),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: containController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Notes',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (notes.id == null) {
                              final title = titleController.text;
                              final content = containController.text;

                              if (title.isNotEmpty && content.isNotEmpty) {
                                ref.read(dbStateProvider).addNotes(NoteModel(
                                      title: title,
                                      content: content,
                                      date: formateDate(),
                                    ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Note Added")));
                                Future.delayed(const Duration(seconds: 5), () {
                                  Navigator.of(context).pop();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Requested to fill all the field !")));
                              }
                            }
                            //if ends of add logic
                            else {
                              final title = titleController.text;
                              final content = containController.text;
                              if (title.isNotEmpty && content.isNotEmpty) {
                                final updateNote = NoteModel(
                                    id: notes.id,
                                    title: title,
                                    content: content,
                                    date: formateDate());
                                ref
                                    .read(dbStateProvider)
                                    .updateNotes(updateNote);
                                //popup message
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Note Updated")));
                                Future.delayed(const Duration(seconds: 5), () {
                                  Navigator.of(context).pop();
                                });
                                //popup message
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Requested to fill all the field !")));
                              }
                            }
                            //else ends of update logic
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 9)),
                          child: const Text("Save")),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
