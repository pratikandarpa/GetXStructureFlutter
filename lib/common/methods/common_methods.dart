import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/common/constants/string_constants.dart';
import 'package:my_app/utils/logger_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/common_widgets.dart';


class CommonMethods {
  static String emailRegExp =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String nameRegExp =
      r'^.{2,70}$';

  static String passwordRegExp =
      r'^.{8,15}$';

  static String mobileRegExp =
      r'^.{7,15}$';

  static String addressRegExp =
      r'^.{2,}$';

  hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // showSnackBar(StringConstants.msgCheckConnection);
      return false;
    } else {
      return true;
    }
  }

  static Future<String> getPlatformVersion() async {
    String version = "1.0.0";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = Platform.isAndroid ? packageInfo.version : packageInfo.version;
    return version;
  }

  static Future<bool> askPermission({Permission? permission, String? whichPermission}) async {
    bool isPermissionGranted = await permission!.isGranted;
    var shouldShowRequestRationale =
    await permission.shouldShowRequestRationale;

    if (isPermissionGranted) {
      return true;
    } else {
      if (!shouldShowRequestRationale) {
        var permissionStatus = await permission.request();
        logger.e("STATUS == $permissionStatus");
        if (permissionStatus.isPermanentlyDenied) {
          CommonWidgets.showCustomDialog(
              Get.context,
              "Permission",
              "Please allow the $whichPermission permission from the settings",
              cancel,
              "Settings",
                  (value)  {
                /// OPEN SETTING CODE
                if (value != null && value ==1) {
                  openAppSettings();
                }
              });
          return false;

        }
        if (permissionStatus.isGranted  || permissionStatus.isLimited) {
          return true;
        } else {
          return false;
        }
      } else {
        var permissionStatus = await permission.request();
        if (permissionStatus.isGranted || permissionStatus.isLimited) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}
