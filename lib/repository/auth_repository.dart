import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:my_app/models/home_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../api_service/api_constant.dart';
import '../api_service/dio_client.dart';
import '../common/enums/method_type.dart';
import '../common/methods/common_methods.dart';
import '../models/common_response.dart';

abstract class AuthRepository {
  // Future<CommonResponse> doInit();

  Future<CommonResponse> doLogin({String emailId, String password});
  Future<HomeModel> getUsers();

  Future<CommonResponse> doLogOut({String token});
  Future<CommonResponse> doDeleteAccount();
}

class AuthRepositoryImpl extends AuthRepository {
  late DioClient _dioClient;

  AuthRepositoryImpl() {
    _dioClient = Get.find();
  }

  // @override
  // Future<CommonResponse> doInit() async {
  //   // TODO: implement doInit
  //
  //   try {
  //     String version = "";
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     version = Platform.isAndroid ? packageInfo.version : packageInfo.version;
  //
  //     var response = await _dioClient.request(
  //         "${ApiConstant.init}/$version/${CommonMethods.getPlatformDevice()}",
  //         MethodType.get, {});
  //
  //     return CommonResponse.fromJson(response, (json) => response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<CommonResponse> doLogin(
      {String emailId = "", String password = ""}) async {
    try {
      var jsonBody = {
        "phone": emailId,
        "password": password,
      };
      var response = await _dioClient.request(
          ApiConstant.login, MethodType.post, jsonBody);

      return CommonResponse.fromJson(response, (json) => response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HomeModel> getUsers(
      {String emailId = "", String password = ""}) async {
    try {
      var response = await _dioClient.request(
          ApiConstant.getUser, MethodType.get);

      return HomeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommonResponse> doDeleteAccount(
      {String token = ""}) async {
    try {

      var response = await _dioClient.request(
          ApiConstant.login, MethodType.delete);

      return CommonResponse.fromJson(response, (json) => response);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<CommonResponse> doLogOut(
      {String token = ""}) async {
    try {

      var response = await _dioClient.request(
          ApiConstant.logout, MethodType.get);

      return CommonResponse.fromJson(response, (json) => response);
    } catch (e) {
      rethrow;
    }
  }
}

