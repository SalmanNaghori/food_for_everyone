import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_for_everyone/app_utils/basic_import.dart';
import 'package:food_for_everyone/app_utils/common_widget/skeleton_shimmer_effect.dart';
import 'package:food_for_everyone/app_utils/utils/enum.dart';
import 'package:food_for_everyone/app_utils/utils/utils.dart';
// import 'package:imin_flutter/app_utils/basic_import.dart';
// import 'package:imin_flutter/app_utils/common_widgets/skeleton_shimmer_effect.dart.dart';

import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

extension StringExtension on String {
  //* -----------------function------------------

  ///Capital first latter
  ///Ex: james bond => James bond
  String capitalizeFirst() {
    if (isEmpty) return this;
    String trimmedText = removeLeadingSpaces();
    return trimmedText[0].toUpperCase() + trimmedText.substring(1).toLowerCase();
  }

  String capitalizeFirstWithAsItIs() {
    if (isEmpty) return this;
    String trimmedText = removeLeadingSpaces();
    return trimmedText[0].toUpperCase() + trimmedText.substring(1);
  }

  // Change date format
  String changeDateFormat({required String inputFormat, required String outputFormat}) {
    DateTime inputDate = DateTime.now();
    if (toString().isNotNullOrEmpty()) {
      try {
        inputDate = DateFormat(inputFormat).parse(toString());
      } catch (e) {
        throw FormatException("Invalid date format: $this");
      }
    }
    return DateFormat(outputFormat).format(inputDate);
  }

  //remove before spacing from the string
  String removeLeadingSpaces() {
    return replaceAll(RegExp(r'^\s+'), '');
  }

  String removeAfterParenthesis() {
    int index = indexOf(' (');
    if (index != -1) {
      return substring(0, index);
    }
    return this;
  }

  ///Remove whitespace
  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  String toPaddedString() {
    return toString().padLeft(2, '0');
  }

  ///show snackBar
  showSnackBar(
      BuildContext context, {
        Color? textColor,
        Color? backgroundColor,
        EdgeInsetsGeometry? margin,
        EdgeInsetsGeometry? padding,
      }) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(this, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        margin: margin,
        padding: padding,
      ));

  toast(
      {ToastLength length = ToastLength.short,
        ToastDisplayGravity gravity = ToastDisplayGravity.bottom,
        Color bgColor = Colors.white,
        Color textColor = Colors.black}) {
    return Fluttertoast.showToast(
        msg: this,
        toastLength: length == ToastLength.longth ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: setToastGravity(gravity),
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  //*  ------------------Widget-------------------

  ///Assets image
  Widget assetImage({
    double? height,
    double? width,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) =>
      Image.asset(
        this,
        height: height,
        width: width,
        color: color,
        fit: fit,
      );

  ///Sve Image
  Widget svgImage({
    double height = 25,
    double width = 25,
    Color? color,
    BoxFit fit = BoxFit.contain,
    bool allowDrawingOutsideViewBox = false,
    ColorFilter? colorFilter,
  }) =>
      SvgPicture.asset(
        this,
        fit: fit,
        width: width,
        height: height,
        color: color,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        colorFilter: colorFilter,
      );

  networkImage({double? height, double? width, BoxFit? fit, Widget? placeHolder}) {
    return CachedNetworkImage(
      imageUrl: this,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) =>
      placeHolder ??
          SkeletonShimmerEffect(
            isLoading: true,
            child: Container(
              color: AppColor.hintColor.withOpacity(0.1),
            ),
          ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  networkImageWithShimmer({double? height, double? width, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: this,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Container(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget networkImageCircle({double height = 50, double width = 50}) {
    return CachedNetworkImage(
      imageUrl: this,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // image: DecorationImage(
          //   image: AssetImage(AppAsset.icDefaultUser),
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  ///AutoSize textview that adjust automatically depend upon screen size
  Widget autoSizeText({
    double stepGranularity = 1,
    double fontSize = 14,
    double minFontSize = 10,
    TextAlign? textAlign,
    Color color = Colors.black,
    String? fontFamily,
    int? maxLine,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      AutoSizeText(
        this,
        textAlign: textAlign,
        minFontSize: minFontSize,
        stepGranularity: stepGranularity,
        maxLines: maxLine,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          overflow: overflow,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
      );

  ///Normal textview
  Widget textView({
    Color color = Colors.black,
    String? fontFamily,
    double fontSize = 14,
    TextAlign? align,
    int? maxLine,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w400,
    TextStyle? style,
  }) {
    return Text(
      this,
      textAlign: align,
      maxLines: maxLine,
      style: style ??
          TextStyle(
            fontSize: fontSize,
            color: color,
            overflow: overflow,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget textButton({
    Color color = Colors.black,
    String? fontFamily,
    double fontSize = 14,
    TextAlign? align,
    int? maxLine,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w400,
    required VoidCallback onTap,
    TextStyle? style,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        this,
        textAlign: align,
        maxLines: maxLine,
        style: style ??
            TextStyle(
              fontSize: fontSize,
              color: color,
              overflow: overflow,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
            ),
      ),
    );
  }

  /// Custom button
  Widget customButton({
    double? height = 50,
    double? width = 200,
    Color? bgColor,
    double fontSize = 14,
    TextStyle? style,
    FontWeight fontWeight = FontWeight.w400,
    double borderRadius = 8,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(GlobalVariable.appContext).colorScheme.primary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              this,
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}

extension StringBufferExtension on StringBuffer {
  void writeIf(bool condition, String value) {
    if (condition) write(value);
  }
}

extension StringNullablity on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  String orEmpty() {
    if (isNullOrEmpty()) return "";
    return this!;
  }

  String orDash() {
    if (isNullOrEmpty()) {
      return "-";
    } else {
      return this!;
    }
  }

  String ifEmpty(String another) {
    if (isNullOrEmpty()) {
      return another;
    } else {
      return this!;
    }
  }

  String removeExtras() {
    if (isNullOrEmpty()) return "";
    var trimmedString = this!.trim();
    var firstReplacedString = trimmedString.replaceAll("-", "");
    var finalReplacedString = firstReplacedString.replaceAll("+", "");
    return finalReplacedString;
  }

  bool isEqualIgnoreCase(String? another) {
    if (isNullOrEmpty() || another.isNullOrEmpty()) return this == another;
    return this!.toLowerCase() == another!.toLowerCase();
  }

  String withColon(dynamic value) {
    return "$this: ${value.toString()}";
  }

  String withEndSpace() {
    return "$this ";
  }

  String withComma(dynamic value) {
    return "$this, ${value.toString()}";
  }

  String withEndDot() {
    return "$this.";
  }

  String withAnother(dynamic value) {
    if (value != null) {
      return "$this ${value.toString()}";
    } else {
      return "$this ";
    }
  }

  String addEndSpace() {
    return "$this ";
  }

  String withBrackets(dynamic value) {
    if (isNullOrEmpty()) return "(${value.toString()})";
    return "$this (${value.toString()})";
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }
}

extension CommonListExtension on List<String> {
  String getListOfString() {
    return join(", ");
  }
}

extension AgeCalculator on String {
  int calculateAgeFromDateString() {
    if (isEmpty) {
      return 0;
    }

    List<String> parts = split('-');
    if (parts.length != 3) {
      throw const FormatException("Date must be in DD-MM-YYYY format");
    }
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return Utils().calculateAge(day, month, year);
  }
}

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

ToastGravity setToastGravity(ToastDisplayGravity gravity) {
  switch (gravity) {
    case ToastDisplayGravity.center:
      return ToastGravity.CENTER;
    case ToastDisplayGravity.bottom:
      return ToastGravity.BOTTOM;
    case ToastDisplayGravity.top:
      return ToastGravity.TOP;
  }
}

extension IterableStringExtension<T> on Iterable<T> {
  String mapAndJoin(String Function(T) mapper) {
    return map(mapper).join(', ');
  }
}

extension PlatformExtension on Platform {
  static int get platformValue {
    if (Platform.isAndroid) {
      return 1;
    } else if (Platform.isIOS) {
      return 2;
    } else {
      return 1;
    }
  }
}