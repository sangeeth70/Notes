import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_by_sangeeth/sqflite/db/database_helper.dart';
import 'package:notes_by_sangeeth/sqflite/features/home/controllers/notes_controller.dart';
import 'package:notes_by_sangeeth/sqflite/features/home/models/item_model.dart';

import '../../../common/widget/custom_button.dart';
import '../../../common/widget/note_component.dart';

class NewNotes extends StatefulWidget {
  final int? id;
  final String? titleData;
  final String? descriptionData;
  const NewNotes({super.key, this.titleData, this.descriptionData, this.id});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  int? insertedId;
  @override
  void initState() {
    title.text = widget.titleData ?? '';
    description.text = widget.descriptionData ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff1B1B1B),
      body: Consumer(builder: (context, ref, _) {
        final isSaved = ref.watch(isSavedNote);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            // Item newItem = Item(
                            //     title: title.text.isEmpty ? 'Title' : title.text,
                            //     description: description.text,
                            //     id: widget.id);
                            // if(description.text.isNotEmpty) {
                            //   if (widget.id == null && insertedId == null) {
                            //     insertedId = await DatabaseHelper.instance.insertItem(newItem);
                            //   } else {
                            //     await DatabaseHelper.instance.updateItem(newItem);
                            //   }
                            //   await ref
                            //       .read(notesStateProvider.notifier)
                            //       .getNotes();
                            //   ref.read(isSavedNote.notifier).state = true;
                            // }
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/icons/back.svg')),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      SizedBox(
                        width: size.width / 1.5,
                        child: TextField(
                          controller: title,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold)),
                          onChanged: (_) {
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) async {
                              if (title.text.isNotEmpty) {
                                if (widget.id == null && insertedId == null) {
                                  Item newItem = Item(
                                      title: title.text.isEmpty
                                          ? 'Title'
                                          : title.text,
                                      description: description.text,
                                      id: widget.id);
                                  insertedId = await DatabaseHelper.instance
                                      .insertItem(newItem);
                                } else {
                                  Item newItem = Item(
                                      title: title.text.isEmpty
                                          ? 'Title'
                                          : title.text,
                                      description: description.text,
                                      id: insertedId ?? widget.id);
                                  await DatabaseHelper.instance
                                      .updateItem(newItem);
                                }
                                await ref
                                    .read(notesStateProvider.notifier)
                                    .getNotes();
                                ref.read(isSavedNote.notifier).state = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  NoteComponent(
                    controller: description,
                    onChanged: (_) {
                      Future.delayed(Duration(seconds: 1)).then((value) async {
                          if (widget.id == null && insertedId == null) {
                            Item newItem = Item(
                                title:
                                    title.text.isEmpty ? 'Title' : title.text,
                                description: description.text,
                                id: widget.id);
                            insertedId = await DatabaseHelper.instance
                                .insertItem(newItem);
                          } else {
                            Item newItem = Item(
                                title:
                                    title.text.isEmpty ? 'Title' : title.text,
                                description: description.text,
                                id: insertedId ?? widget.id);
                            await DatabaseHelper.instance.updateItem(newItem);
                          }
                          await ref
                              .read(notesStateProvider.notifier)
                              .getNotes();
                          ref.read(isSavedNote.notifier).state = true;
                        }
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
