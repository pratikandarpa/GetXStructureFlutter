import 'package:get/get.dart';
import '../pages/login/login_bindings.dart';
import '../pages/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.login;

  static final routes = [
    // GetPage(
    //     name: _Paths.splash,
    //     page: () => const SplashView(),
    //     binding: SplashBindings()),
    GetPage(
        name: _Paths.login,
        page: () => const LoginView(),
        binding: LoginBindings()),
  ];
}
