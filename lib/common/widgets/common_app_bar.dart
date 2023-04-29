import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/common/constants/image_constants.dart';
import 'package:my_app/common/widgets/common_widgets.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';

class CommonAppBar {
  //Text
  static AppBar commonAppBar(
      {String? titleName,
      bool? showActions = false,
      Widget? child,
      bool? showBackIcon = true}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: showBackIcon! ? 56 : 0,
      leading: showBackIcon
          ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(
                    ImageConstants.arrowLeftIcon,
                    color: ColorConstants.fillColor,
                    height: 24,
                    width: 24,
                  )),
            )
          : Container(),
      centerTitle: false,
      title: Transform.translate(
        offset: Offset(showBackIcon?-16:0,0),
        child: CommonWidgets.commonText(
          text: titleName,
          fontWeight: FontWeightConstants.bold,
          fontSize: 18,
          color: ColorConstants.fillColor,
        ),
      ),
      actions: [showActions! ? child! : Container()],
    );
  }
}
