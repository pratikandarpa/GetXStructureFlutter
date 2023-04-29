import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: GestureDetector(
              onTap: (){
                controller.getUsers();
              },
              child: Center(child: Text("Press Me"))),
        ),
      ),
    );
  }
}
