import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteDetails extends ConsumerWidget {
  const NoteDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController title = TextEditingController();
    TextEditingController contain = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              TextField(
                controller: contain,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Contain"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
