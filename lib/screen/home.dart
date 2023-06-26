import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui/controller/todo_controller.dart';
import 'package:login_ui/screen/add_todo_page.dart';

import '../style/app_color.dart';

class HomeScreen extends GetView<TodoController> {
  HomeScreen({super.key});

  void signOut() {
    final auth = FirebaseAuth.instance;
    auth.signOut();
  }

  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.sort,
          size: 35,
          color: Color(0xFF9C89B8),
        ),
        title: Center(
          child: Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFF9C89B8), width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Category',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                        fontSize: 13),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.expand_more),
                  color: const Color(0xFF9C89B8),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AddTask()));
            },
            icon: const Icon(
              Icons.add,
              color: Color(0xFF9C89B8),
            ),
            iconSize: 40,
          ),
        ],
      ),
      body: Column(
        children: [
          _create(),
          _todoList(),
        ],
      ),
    );
  }

  Widget _todoList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todoModel = controller.todos[index];
            return ListTile(
              leading: (todoModel.isDone!)
                  ? GestureDetector(
                      onTap: () => controller.deleteTodo(todoModel.id!),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppColors.pink,
                        size: 35,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.updateTodo(todoModel.id!);
                      },
                      child: const Icon(
                        Icons.circle_outlined,
                        size: 35,
                        color: AppColors.pink,
                      ),
                    ),
              subtitle: Text(todoModel.time.toString()),
              title: Text(todoModel.todo),
            );
          },
        ),
      ),
    );
  }

  Widget _create() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            controller: controller.createCon,
          ),
        ),
        ElevatedButton(
          onPressed: () => controller.create(),
          child: const Icon(Icons.send),
        ),
      ],
    );
  }
}
