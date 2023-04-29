import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_app/common/constants/string_constants.dart';
import 'package:my_app/common/methods/common_methods.dart';
import '../common/enums/method_type.dart';
import '../common/widgets/common_widgets.dart';
import '../routes/app_pages.dart';
import '../utils/storage_utils.dart';
import 'api_constant.dart';
import 'api_interceptor.dart';

class DioClient extends GetxService {
  late Dio _dio;

  Future<DioClient> init() async {
    _dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl))
      ..interceptors.add(ApiInterceptors());
    return this;
  }

  Future<Map<String, dynamic>> request(
      String url, MethodType method, [dynamic params]) async {
    try {
      Response response;
      if (await CommonMethods.checkConnectivity()) {
        if (method == MethodType.post) {
          response = await _dio.post(url, data: params);
        } else if (method == MethodType.delete) {
          response = await _dio.delete(url);
        } else if (method == MethodType.patch) {
          response = await _dio.patch(url);
        } else {
          response = await _dio.get(
            url,
          );
        }

        return response.data;
      } else {
        return {"message": noInternetConnection, "status": false};
      }
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 401) {
        Get.offAllNamed(Routes.login);
        StorageUtil.clearLoginData();
        CommonWidgets.showSnackBar(
            sessionExpired);
      }
      return {"message": dioError.response?.data["message"], "status": false};
    } catch (error) {
      return {"message": error.toString(), "status": false};
    }
  }

  Future<Map<String, dynamic>> multipartRequest(
      String url, MethodType method, dynamic params) async {
    try {
      Response response;
      if (await CommonMethods.checkConnectivity()) {
        response = await _dio.post(url, data: params,options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }));
        return response.data;
      } else {
        return {"message": noInternetConnection, "status": false};
      }
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 401) {
        Get.offAllNamed(Routes.login);
        StorageUtil.clearLoginData();
        CommonWidgets.showSnackBar(
            sessionExpired);
      }
      return {"message": dioError.response?.data["message"], "status": false};
    } catch (error) {
      return {"message": error.toString(), "status": false};
    }
  }

}
