import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui/screen/signin.dart';

import 'binding/init_binding.dart';
import 'controller/auth_controller.dart';
import 'utils/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization
      .then((value) => {Get.put(AuthController()), Get.testMode = true});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Signin(),
      initialBinding: InitBinding(),
    );
  }
}
