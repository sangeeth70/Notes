import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../db/database_helper.dart';
import '../models/item_model.dart';

final notesStateProvider = StateNotifierProvider<NotesDataController,NotesDataStates>((ref) {
  return NotesDataController(ref);
});

final isSavedNote = StateProvider.autoDispose<bool>((ref) => true);

final notesDataProvider = StateProvider<List<Item>>((ref) => []);

class NotesDataController extends StateNotifier<NotesDataStates>{
  final Ref ref;
  NotesDataController(this.ref) : super(NotesDataInitial()){
    getNotes();
  }

  getNotes()async{
    try{
      state = NotesDataLoading();
      final response = await DatabaseHelper.instance.getItems();
      ref.read(notesDataProvider.notifier).state = response;
      state = NotesDataLoaded(response: response);
    }catch(e){
      state = NotesDataError();
    }
  }

}

abstract class NotesDataStates{}
class NotesDataInitial extends NotesDataStates{}
class NotesDataLoading extends NotesDataStates{}
class NotesDataLoaded extends NotesDataStates{
  final List<Item> response;
  NotesDataLoaded({required this.response});
}
class NotesDataError extends NotesDataStates{}