import 'package:flutter/material.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';

class AppTextFieldPage extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  // final Color color;
  final bool textHide;
  final bool readOnly;
  final bool enable;
  final TextInputType? inputType;
  final IconButton? suffixIcon;

  const AppTextFieldPage(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.icon,
      // required this.color,
      this.textHide = false,
      this.enable = true,
      this.readOnly = false,
      this.inputType,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: textController,
            obscureText: textHide,
            readOnly: readOnly,
            enabled: enable,
            keyboardType: inputType,
            style: TextStyle(
              fontSize: Dimensions.font14,
            ),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.borderwhite, width: 1),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.borderGray, width: 1),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.textGray),
                prefixIcon: Icon(icon, color: AppColors.iconGray),
                suffixIcon: suffixIcon,
                filled: true,
                fillColor: AppColors.backgroundWhite),
          ),
        ),
      ],
    );
  }
}
