import 'package:login_ui/data/model/todo_model.dart';
import 'package:login_ui/data/provider/firebase_db.dart';

class TodoRepository {
  static Stream<List<TodoModel>> fetchTodos() => TodoApi.getTodos();
}
