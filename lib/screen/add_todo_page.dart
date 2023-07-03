import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screen/home.dart';
import 'package:get/get.dart';
import 'package:login_ui/style/app_color.dart';

import '../controller/todo_controller.dart';

class AddTodoPage extends GetView<TodoController> {
  AddTodoPage({Key? key}) : super(key: key);

  final ValueNotifier<DateTime> selectedDate =
      ValueNotifier<DateTime>(DateTime.now());

  final ValueNotifier<Color> selectedColor = ValueNotifier<Color>(Colors.grey);

  Widget buildTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF9C89B8),
        ),
      ),
      child: child,
    );
  }

  Widget buildColorContainer(Color color) {
    return GestureDetector(
      onTap: () {
        selectedColor.value = color;
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
      ),
    );
  }

  String getFormattedDate(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF9C89B8),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle('Name'),
                buildContainer(
                  child: SizedBox(
                    width: 300,
                    child: TextField(controller: controller.createCon),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Date'),
                buildContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getFormattedDate(DateTime.now()),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.calendar,
                            color: Color(0xFF9C89B8)),
                        onPressed: () {
                          selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Category'),
                buildContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.expand_more, color: Color(0xFF9C89B8))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Level Importance'),
                buildContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.expand_more, color: Color(0xFF9C89B8))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Color'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildColorContainer(AppColors.green),
                    buildColorContainer(AppColors.lightred),
                    buildColorContainer(AppColors.orange),
                    buildColorContainer(AppColors.yellow),
                    buildColorContainer(AppColors.lightblue2),
                    buildColorContainer(AppColors.pink),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Set Alarm'),
                buildContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.expand_more,
                          color: Color(0xFF9C89B8),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTitle('Time During'),
                buildContainer(
                    child: const SizedBox(width: 300, child: TextField())),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF9C89B8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      controller.create();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    containerColor: selectedColor.value,
                                  )));
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
