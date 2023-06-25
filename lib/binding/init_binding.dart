import 'package:get/get.dart';

import '../controller/todo_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
  }
}
