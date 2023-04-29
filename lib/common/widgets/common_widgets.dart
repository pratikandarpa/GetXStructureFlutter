import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../methods/common_methods.dart';

class CommonWidgets {

  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showSnackBar(msgCheckConnection);
      return false;
    } else {
      return true;
    }
  }

  static showSnackBar(String message, {Color? bgColor}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(message),
      titleText: Container(),
      borderColor: ColorConstants.selectedBorderColor,
      borderWidth: 1,
      backgroundColor: bgColor ?? Colors.white,
      colorText: Theme.of(Get.context!).colorScheme.surface,
      isDismissible: false,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(10.0),
      /*mainButton: TextButton(
      child: Text('Undo'),
      onPressed: () {},
    ),*/
    );
  }

  static Widget commonText({
    Color? color = Colors.black,
    double? fontSize,
    double? height,
    String? text,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLine = 3,
    String fontFamily = FontFamilyConstants.fontName,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return Text(
      text ?? "",
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        decoration: textDecoration,
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        fontFamily: fontFamily,
      ),
    );
  }

  static Widget commonFilledButton({
    required BuildContext? context,
    String? title,
    Color? color = ColorConstants.blackColor,
    Color? textColor = ColorConstants.whiteColor,
    Color borderColor = Colors.transparent,
    double? fontSize = 14,
    String? text,
    double? topPadding,
    FontWeight? fontWeight = FontWeightConstants.bold,
    // VoidCallback? onSubmit,
    void Function()? onclick,
    String fontFamily = FontFamilyConstants.fontName,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: GestureDetector(
        onTap: () {
          onclick?.call();
          CommonMethods().hideKeyboard(context!);
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: borderColor,
              width: borderColor == Colors.transparent ? 0 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              title ?? "",
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  height: 1.0,
                  fontWeight: fontWeight,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: fontFamily),
            ),
          ),
        ),
      ),
    );
  }

  static showCustomDialog(context, String titleName, String titleContent,
      String leftButtonText, String rightButtonText, Function(int) callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)), //this right here
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CommonWidgets.commonText(
                          textAlign: TextAlign.left,
                          text: titleName,
                          fontFamily: FontFamilyConstants.fontName,
                          fontWeight: FontWeightConstants.bold,
                          fontSize: FontConstants.font_18,
                          color: ColorConstants.blackColor),
                      const SizedBox(
                        height: 24,
                      ),
                      CommonWidgets.commonText(
                          textAlign: TextAlign.center,
                          text: titleContent,
                          fontFamily: FontFamilyConstants.fontName,
                          fontWeight: FontWeightConstants.medium,
                          fontSize: FontConstants.font_16,
                          color: ColorConstants.blackColor),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonWidgets.commonFilledButton(
                                context: Get.context,
                                onclick: () {
                                  Navigator.pop(context);
                                  callback(0);
                                },
                                color: ColorConstants.fillColor,
                                borderColor: ColorConstants.selectedBorderColor,
                                fontWeight: FontWeightConstants.semiBold,
                                fontSize: 18,
                                title: leftButtonText,
                                textColor: ColorConstants.blackColor),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CommonWidgets.commonFilledButton(
                                context: Get.context,
                                onclick: () {
                                  Navigator.pop(context);
                                  callback(1);
                                },
                                color: ColorConstants.blackColor,
                                borderColor: ColorConstants.selectedBorderColor,
                                fontWeight: FontWeightConstants.semiBold,
                                fontSize: 18,
                                title: rightButtonText,
                                textColor: ColorConstants.whiteColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ]),
              ));
        });
  }


  static Widget loadNetworkImage(String url,
      {double? borderRadius, double? width, double? height}) {
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.white,
                    loop: 15,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConstants.whiteColor),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.network(
                    url,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceHolderImage(borderRadius),
                    fit: BoxFit.fill,
                  );
                },
                fit: BoxFit.fill,
              ),
            )
          : _buildPlaceHolderImage(borderRadius),
    );
  }

  static Widget _buildPlaceHolderImage(double? borderRadius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        color: const Color(0xFFe6e6e6),
        child: Center(
          child: SvgPicture.asset(
            ImageConstants.splashLogo,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
