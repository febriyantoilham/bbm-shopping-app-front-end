import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

void customSnackBar(String message,
    {bool isError = true, String title = "Error", color = Colors.red}) {
  Get.snackbar(
    title,
    message,
    titleText: TitleText(
      text: title,
      color: Colors.white,
    ),
    margin: EdgeInsets.symmetric(
      vertical: Dimensions.statusBarWidth,
      horizontal: Dimensions.width20,
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: color,
    duration: const Duration(seconds: 2),
  );
}
