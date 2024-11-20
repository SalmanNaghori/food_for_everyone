import 'package:flutter/material.dart';
import 'package:food_for_everyone/app_utils/basic_import.dart';
import 'package:nil/nil.dart';

extension CenterExtension on Widget {
  /// Wrap with center
  Center toCenter() {
    return Center(
      child: this,
    );
  }

  /// Wrap with gesture detector
  Widget onTap(Function() function) => GestureDetector(
    onTap: function,
    child: this,
  );

  Padding paddingAll(double value, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.all(value),
    child: this,
  );

  Padding paddingSymmetric({
    Key? key,
    double? vertical,
    double? horizontal,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(horizontal: horizontal ?? 0, vertical: vertical ?? 0),
        child: this,
      );

  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    Key? key,
  }) =>
      Padding(
        key: key,
        padding:
        EdgeInsets.only(top: top, left: left, bottom: bottom, right: right),
        child: this,
      );

  Widget nullWidget() {
    return nil;
  }

  Container marginAll(double value, {Key? key}) {
    return Container(
      margin: EdgeInsets.all(value),
      child: this,
    );
  }

  Container marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    Key? key,
  }) {
    return Container(
      margin:
      EdgeInsets.only(top: top, left: left, bottom: bottom, right: right),
      child: this,
    );
  }

  Widget customWidgetButton({
    double? height = 50,
    double? width = 200,
    Color? bgColor,
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
            child: this,
          ),
        ),
      ),
    );
  }

  Widget minimizeBox(
      {Color? bgColor, double? borderRadius = 8, required VoidCallback onTap, String? text, TextStyle? style, MainAxisAlignment? mainAxisAlignment}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: [
            paddingSymmetric(horizontal: Dimensions.h12, vertical: Dimensions.h8).customWidgetButton(
              width: null,
              height: null,
              onTap: onTap,
              bgColor: bgColor ?? AppColor.blueColor,
              borderRadius: borderRadius ?? Dimensions.r10,
            ),
          ],
        ),
      ],
    );
  }
}

extension TextStyleExtensions on TextStyle {
  TextStyle withBlur({double blurRadius = 4.0, Color? color}) {
    return copyWith(
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..color = color ?? AppColor.descriptionTextColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    );
  }
}