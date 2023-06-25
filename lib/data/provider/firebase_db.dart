import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_ui/data/model/todo_model.dart';
import 'package:login_ui/utils/firebase_constants.dart';

class TodoApi {
  static Stream<List<TodoModel>> getTodos() {
    return firebasestore
        .collection('todo')
        .orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> todos = [];
      for (var doc in query.docs) {
        final todoModel = TodoModel.fromJson(doc);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  static void createTodo(TodoModel todoModel) async {
    return firebasestore.collection('todo').doc().set(
        {'todo': todoModel.todo, 'time': Timestamp.now(), 'isDone': false});
  }

  static void updateTodo(String id) {
    firebasestore.collection('todo').doc(id).update({'isDone': true});
  }

  static void deleteTodo(String id) {
    firebasestore.collection('todo').doc(id).delete();
  }
}
