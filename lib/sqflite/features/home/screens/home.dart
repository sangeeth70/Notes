import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_by_sangeeth/sqflite/features/home/screens/widgets/delete_popup.dart';
import 'package:notes_by_sangeeth/sqflite/features/home/screens/widgets/note_tile.dart';
import '../../../db/database_helper.dart';
import '../../new_note/screens/ui/new_note.dart';
import '../controllers/notes_controller.dart';

class NotesHome extends ConsumerWidget {
  NotesHome({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesProvider = ref.watch(notesStateProvider);
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xff1B1B1B),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                if (notesProvider is NotesDataLoaded &&
                    notesProvider.response.isNotEmpty)
                  Expanded(
                    child: GridView.builder(

                      physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 30),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: size.width / (size.height / 1.5),
                        ),
                        itemCount: notesProvider.response.length,
                        itemBuilder: (context, index) {
                          final data = notesProvider.response[index];
                          return NoteTile(
                            title: notesProvider.response[index].title,
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                                    return FadeTransition(opacity: animation,child: child,);
                                  },
                                  transitionDuration: const Duration(milliseconds: 200),
                                  pageBuilder: (context,animation,secAnimation) => NewNotes(id: data.id,titleData: data.title,descriptionData: data.description)));
                            },
                            onDeleteTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeletePopup(
                                      onNoTap: () {
                                        Navigator.pop(context);
                                      },
                                      onYesTap: () async {
                                        await DatabaseHelper.instance
                                            .deleteItems(notesProvider
                                            .response[index].id ??
                                            0);
                                        await ref
                                            .read(notesStateProvider.notifier)
                                            .getNotes();
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            },
                            note: notesProvider.response[index].description,
                          );
                        }),
                  ),
                if (notesProvider is NotesDataLoaded && notesProvider.response.isEmpty)
                  Container(
                    alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height/3),
                      child: const Text(
                    "Get your thoughts down quickly and easily.\n Tap the '+' to begin a new note.",
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Mukta', color: Color(0xff7B7B7B)),
                    textAlign: TextAlign.center,
                  )),
                if (notesProvider is NotesDataLoading)
                  Center(child: CircularProgressIndicator(color: Colors.white)),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.center,
                end: FractionalOffset.bottomCenter,
                stops: [0.7,0.88, 1],
                colors: [
                  Color.fromARGB(255, 27, 27, 27),
                  Color.fromARGB(120, 27, 27, 27),
                  Color.fromARGB(10, 27, 27, 27),
                ],
              )),
              child: const Text(
                "Notes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: const BorderSide(width: 1, color: Color(0xff7B7B7B))),
        backgroundColor: const Color(0xff343434),
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                return FadeTransition(opacity: animation,child: child,);
              },
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (context,animation,secAnimation) => const NewNotes()));

        },
        child: const Icon(
          Icons.add,
          color: Color(0xff7B7B7B),
        ),
      ),
    );
  }
}





