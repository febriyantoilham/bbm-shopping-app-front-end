import 'package:flutter/material.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

// ignore: must_be_immutable
class ProfileWidget extends StatelessWidget {
  AppIcon appIcon;
  Icon rightAppIcon;
  TitleText titleText;
  Color color;

  ProfileWidget({
    Key? key,
    required this.appIcon,
    required this.titleText,
    this.color = AppColors.secondaryColor,
    this.rightAppIcon = const Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
      size: 20,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              appIcon,
              SizedBox(
                width: Dimensions.width20,
              ),
              titleText,
            ],
          ),
          rightAppIcon,
        ],
      ),
    );
  }
}
