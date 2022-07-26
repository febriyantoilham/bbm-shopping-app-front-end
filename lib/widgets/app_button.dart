import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  double size;
  FontWeight fontWeight;

  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onTap;
  AppButton({
    Key? key,
    required this.text,
    this.size = 18,
    this.fontWeight = FontWeight.normal,
    this.bgColor = AppColors.backgroundButton,
    this.borderColor = Colors.transparent,
    this.textColor = AppColors.textWhite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10, horizontal: Dimensions.width20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            color: bgColor,
            border: Border.all(width: 1, color: borderColor)),
        child: Center(
          child: TitleText(
            text: text,
            color: textColor,
            size: size,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
