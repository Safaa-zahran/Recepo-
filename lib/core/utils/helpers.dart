import 'dart:developer';

//import 'package:posts_app/core/model/products_response.dart';
import 'package:posts_app/core/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
//import 'package:posts_app/core/model/address.dart';

class Helpers {
  static String? egyptianMobileNumberValidator(String? mobileNumber) {
    if (mobileNumber != null) {
      if (mobileNumber.length != 11 ||
          (!mobileNumber.startsWith('010') &&
              !mobileNumber.startsWith('011') &&
              !mobileNumber.startsWith('012') &&
              !mobileNumber.startsWith('015'))) {
        return LocaleKeys.enterValidEgyptianNumber.tr();
      }
    }
    return null;
  }

 /* static String formatAddress(Address address) {
    return "${address.buildNumber!} ${address.street!} ${LocaleKeys.floor
        .tr()}: ${address.floor!}  ${LocaleKeys.flatNumber.tr()}: ${address
        .flat!}";
  }
*/
  static void debugDioError(DioError error) {
    if (kDebugMode) {
      log(error.response!.statusCode.toString());
      log(error.response!.data.toString());
    }
  }

  static void logDioResponse(Response response) {
    if (kDebugMode) {
      log('URL: ${response.requestOptions.uri}');
      log('STATUS_CODE: ${response.statusCode}');
      log('BODY: ${response.data}');
    }
  }

  static bool isEnglish(BuildContext context) =>
      context.locale == const Locale('en');

  static bool isArabic(BuildContext context) =>
      context.locale == const Locale('ar');

  static String formatPrice(num price) =>
      '${price.toStringAsFixed(2)} ${LocaleKeys.le.tr()}';


  static String formatTrendingPrice(num price) =>
      '${price.toStringAsFixed(0)} ${LocaleKeys.le.tr()}';


  //TimeOfDay startAndEndTimeValidation = TimeOfDay.fromDateTime(selectedDateForTime.add(const Duration(minutes: 60, days: 0)));
  TextEditingController? endTimeController = TextEditingController();


  static Future<DateTime?> showDateTimePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    var time = TimeOfDay.fromDateTime(
        selectedDate.add(const Duration(minutes: 60)));
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: time,
      ).then((value) {
        if (DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          value!.hour,
          value.minute,
        ).isAfter(selectedDate)) {
          return value;
        } else {
          print('Error');

          showSnackbar(
              context: context,
              status: SnackbarStatus.info,
              message: 'The end time should be after the start time');
        }
      });
      /*     if(selectedTime != null && selectedTime != selectedTimee){
        selectedTimee = selectedTime;
      }*/
      if (selectedTime != null) {
        final selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        return selectedDateTime;
      }
    }
    return null;
  }


/*
  showEndTimePicker({context}) {
    DateTime selectedDate = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate.add(const Duration(minutes: 60, days: 0))),
    ).then((value) {
      //var day = todayDateBeforeFormat;
      // print(value);
      // print(value);
      if (DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        value!.hour,
        value.minute,
      ).isAfter(startAndEndTimeValidation)) {
         endTimeController!.text =
            DateFormat('hh:mm a', ).format(
                DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute));
      } else {
        print('Error');
         endTimeController!.text =
            DateFormat('hh:mm a',).format(
                startAndEndTimeValidation
                    .add(const Duration(hours: 1)));
        showSnackbar(
            context: context,
            status: SnackbarStatus.info,
            message: 'The end time should be after the start time');
      }
    });
  }
*/

/* static double calculatePriceAfterDiscount({
    required num price,
    required double discount,
    required DiscountUnit discountUnit,
  }) {
    if (discountUnit == DiscountUnit.percentage) {
      return price - (price * discount / 100);
    } else {
      return price - discount;
    }
  }
}
*/
}