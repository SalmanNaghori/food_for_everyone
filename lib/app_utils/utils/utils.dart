import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_for_everyone/app_utils/basic_import.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:intl/intl.dart';

class Utils {
  openReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      'Error in open review'.toast();
    }
  }

  Widget editText(TextEditingController controller,
      {String hintText = '',
      TextInputType keyboardType = TextInputType.name,
      String error = '',
      Function(String?)? validation,
      bool readOnly = false,
      TextCapitalization capitalization = TextCapitalization.none,
      String? key}) {
    return TextFormField(
      key: key != null ? Key(key) : null,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      textCapitalization: capitalization,
      textAlign: TextAlign.left,
      readOnly: readOnly,
      cursorColor: Colors.black,
      validator: ((value) {
        if (validation != null) {
          return validation(value);
        } else {
          if (value != null && value.trim().isEmpty) {
            return error;
          }
          return null;
        }
      }),
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 4),
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
      ),
      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }

  int calculateAge(int day, int month, int year) {
    final now = DateTime.now();
    int age = now.year - year;

    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    return age;
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  String formatDateTime(DateTime dateTime) {
    String dayOfWeek = Const.days[dateTime.weekday % 7];
    String month = Const.months[dateTime.month - 1];
    String day = dateTime.day.toString().padLeft(2, '0');

    String hour = dateTime.hour % 12 == 0
        ? '12'
        : (dateTime.hour % 12).toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$dayOfWeek, $month $day - $hour:$minute $period';
  }

  List<bool> generateRandomBooleans(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextBool());
  }

  static int convertAmPmToUtcMinutes(
      {required String selectedTime, required String timeFormat}) {
    final onlyTimeFromString =
        selectedTime.split('-').lastOrNull?.toUpperCase().trim();
    final parsedTime = DateFormat(timeFormat).parse(onlyTimeFromString!);
    // Create a DateTime object with today's date and the parsed time
    final dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      parsedTime.hour,
      parsedTime.minute,
    );

    // Get the UTC time
    final utcDateTime = dateTime.toUtc();
    final utcMinutes = utcDateTime.hour * 60 + utcDateTime.minute;
    return utcMinutes;
  }
}
