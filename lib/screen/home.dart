import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/controller/todo_controller.dart';
import 'package:login_ui/screen/add_todo_page.dart';
import 'package:login_ui/style/app_color.dart';

class HomeScreen extends GetView<TodoController> {
  HomeScreen({
    super.key,
  });

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
              border: Border.all(color: const Color(0xFF9C89B8), width: 1),
            ),
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
                  MaterialPageRoute(builder: (context) => AddTodoPage()));
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
          _task(),
          _todoList(),
          _logout(),
        ],
      ),
    );
  }

  Widget _task() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Task',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF49444C),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text('today', style: GoogleFonts.plusJakartaSans()),
        )
      ],
    );
  }

  Widget _todoList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todoModel = controller.todos[index];
            final formattedTime =
                DateFormat('hh:mm a').format(todoModel.time!.toDate());
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: Row(
                children: [
                  (todoModel.isDone!)
                      ? GestureDetector(
                          onTap: () => controller.deleteTodo(todoModel.id!),
                          child: const Icon(
                            Icons.check_circle,
                            color: AppColors.lightred,
                            size: 50,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.updateTodo(todoModel.id!);
                          },
                          child: const Icon(
                            Icons.circle_outlined,
                            size: 50,
                            color: AppColors.lightred,
                          ),
                        ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: controller.selectedColor.value,
                          borderRadius: BorderRadius.circular(10)),
                      width: 40,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              todoModel.todo,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF49444C),
                              ),
                            ),
                            Text(
                              formattedTime,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.0,
                                color: const Color(0xFF49444C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _logout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
      ],
    );
  }
}
