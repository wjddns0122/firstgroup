import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_ui/screen/signin.dart';

import '../screen/home.dart';
import '../utils/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();

    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, moveToPage);
  }

  moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => const Signin());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void register(String email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: empty_catches
    } catch (firebaseAuthException) {}
  }

  void login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: empty_catches
    } catch (firebaseAuthException) {}
  }
}
