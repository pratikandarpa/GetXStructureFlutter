import 'package:get/get.dart';

import '../../repository/auth_repository.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.put<LoginController>(LoginController());
  }
}
