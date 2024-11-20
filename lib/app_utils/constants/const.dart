import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_for_everyone/app_utils/constants/app_color.dart';
import 'package:food_for_everyone/app_utils/extension/string_extension.dart';
// import 'package:imin_flutter/app_utils/basic_import.dart'
// import 'package:imin_flutter/app_utils/network/api_url.dart';
// import 'package:imin_flutter/features/tab_activity/activity_main_tab/model/model_activity_entity.dart';

class Const {
  static NavigationBarColor navigationBarColor = NavigationBarColor();
  static String packageName = 'com.food_for_everyone';
  static String appStoreID = 'id639483216';
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;
  // static var apiManager = APIManager.getInstance(baseUrl: NetworkConstant.BASE_URL_API);
  static int totalSomeWhereElseQue = 2;
  static int totalSignUpQue = 13;
  static int totalInterest = 25;
  static const int totalImages = 6;
  static const int maxSparkLimit = 3;


  static const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  static const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
  static const imageExtensions = [".jpg", ".jpeg", ".png"];


  static const List<String> costOptionList = ["€", "€€", "€€€", "€€€€"];


  static const timeList = ["Morning", "Afternoon", "Evening", "Night"];
  static List<String> durationList = ["Less than 2 hours", "2-4 hours", "4-6 hours", "6-10 hours", "more than 10 hours"];

  static const int minAge = 18;
  static const int maxAge = 60;
  static Future<void> config() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfoPlugin.androidInfo;
    } else {
      iosInfo = await deviceInfoPlugin.iosInfo;
    }
  }

  static DateTime? backButtonPressedTime;

  static Future<bool> showExitPopup(BuildContext context) async {
    DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2

    bool backButton = backButtonPressedTime == null || currentTime.difference(backButtonPressedTime!) > const Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      'Press again to exit'.toast();
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }
}

class NavigationBarColor {
  setNavigationColor(Color navColor) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: navColor,
        systemNavigationBarDividerColor: navColor,
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  final double height;
  final double? width;
  final Color? dividerColor;

  const MyDivider({super.key, this.height = .5, this.dividerColor, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(color: dividerColor ?? AppColor.colorGrayBorder));
  }
}