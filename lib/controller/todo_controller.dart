import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui/data/model/todo_model.dart';
import 'package:login_ui/data/provider/firebase_db.dart';
import 'package:login_ui/data/repository/todo_repository.dart';

class TodoController extends GetxController {
  final Rx<List<TodoModel>> _todos = Rx<List<TodoModel>>([]);
  final TextEditingController _controller = TextEditingController();

  List<TodoModel> get todos => _todos.value;
  TextEditingController get createCon => _controller;

  @override
  void onReady() {
    super.onReady();
    _todos.bindStream(TodoRepository.fetchTodos());
  }

  // 생성 함수
  void create() {
    final todo = _controller.value.text;
    if (_controller.value.text.isNotEmpty) {
      try {
        final todoModel = TodoModel.toJson(todo);
        TodoApi.createTodo(todoModel);
        _controller.clear();
      } catch (e) {
        debugPrint("error");
      }
    }
  }

  // 업데이트 함수
  void updateTodo(String id) {
    try {
      TodoApi.updateTodo(id);
    } catch (e) {
      debugPrint("error");
    }
  }

  // 삭제 함수
  void deleteTodo(String id) {
    try {
      TodoApi.deleteTodo(id);
    } catch (e) {
      debugPrint("error");
    }
  }
}
