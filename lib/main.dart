import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/api_service/dio_client.dart';
import 'package:my_app/common/constants/color_constants.dart';
import 'package:my_app/common/constants/font_constants.dart';
import 'package:my_app/pages/login/login_bindings.dart';
import 'package:my_app/routes/app_pages.dart';

Future<void> main(main) async {

  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(const MyApp());
  configLoading();
}

initServices() async {
  await Get.putAsync<DioClient>(() => DioClient().init());
}

class MyApp extends StatefulWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorConstants.blackColor,
      systemNavigationBarDividerColor: ColorConstants.greyBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeightConstants.regular,
            )),
        primaryColor: ColorConstants.buttonColor,
        colorScheme: const ColorScheme.highContrastLight(
            primary: ColorConstants.buttonColor),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        focusColor: ColorConstants.whiteColor,
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialBinding: LoginBindings(),
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorConstants.whiteColor
    ..backgroundColor = ColorConstants.bgColor
    ..indicatorColor = ColorConstants.whiteColor
    ..textColor = ColorConstants.whiteColor
    ..maskColor = Colors.deepOrange.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
