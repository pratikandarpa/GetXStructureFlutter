import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/utils/storage_utils.dart';

import '../../common/widgets/common_widgets.dart';
import '../../repository/auth_repository.dart';
import '../../utils/logger_util.dart';

class LoginController extends GetxController {
  final _authRepository = Get.find<AuthRepository>();


  void getUsers() async {
    EasyLoading.show();
    try {
      // var homeModelResponse = await _authRepository.doLogin(
      //     emailId: "",
      //     password: "");

      var homeModelResponse = await _authRepository.getUsers();

      EasyLoading.dismiss();
      if (homeModelResponse.results.isNotEmpty) {
        print("ABC ${homeModelResponse}");
      } else {
        CommonWidgets.showSnackBar("Error");
        logger.e("Error");
      }
    } catch (error) {
      EasyLoading.dismiss();
      logger.e("Controller>>>>>> error $error");
    }
  }

  void doSignIn() async {
      EasyLoading.show();
      try {
        // var commonResponse = await _authRepository.doLogin(
        //     emailId: "",
        //     password: "");

        var commonResponse = await _authRepository.doLogin(
            emailId: "1234567897",
            password: "12345678");

        EasyLoading.dismiss();
        if (commonResponse.message.isNotEmpty && commonResponse.status) {
            print("ABC ${commonResponse.bearerToken}");
            StorageUtil.setData(
                StorageUtil.keyToken, commonResponse.bearerToken);
            // doSignOut();
            doDeleteAccount();
        } else {
          CommonWidgets.showSnackBar(commonResponse.message);
          logger.e(commonResponse.message);
        }
      } catch (error) {
        EasyLoading.dismiss();
        logger.e("Controller>>>>>> error $error");
      }
    }

  void doSignOut() async {
    EasyLoading.show();
    try {
      // var commonResponse = await _authRepository.doLogin(
      //     emailId: "",
      //     password: "");


      var commonResponse = await _authRepository.doLogOut();

      EasyLoading.dismiss();
      if (commonResponse.message.isNotEmpty && commonResponse.status) {
        print("ABC ${commonResponse.message}");

      } else {
        CommonWidgets.showSnackBar(commonResponse.message);
        logger.e(commonResponse.message);
      }
    } catch (error) {
      EasyLoading.dismiss();
      logger.e("Controller>>>>>> error $error");
    }
  }

  void doDeleteAccount() async {
    EasyLoading.show();
    try {
      // var commonResponse = await _authRepository.doLogin(
      //     emailId: "",
      //     password: "");


      var commonResponse = await _authRepository.doDeleteAccount();

      EasyLoading.dismiss();
      if (commonResponse.message.isNotEmpty && commonResponse.status) {
        print("ABC ${commonResponse.message}");

      } else {
        CommonWidgets.showSnackBar(commonResponse.message);
        logger.e(commonResponse.message);
      }
    } catch (error) {
      EasyLoading.dismiss();
      logger.e("Controller>>>>>> error $error");
    }
  }
}
