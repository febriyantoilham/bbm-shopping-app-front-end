// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';

class SuperTitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  FontWeight fontWeight;
  TextOverflow overFlow;
  SuperTitleText({
    Key? key,
    this.color = const Color(0xFF0d1b2a),
    required this.text,
    this.size = 40,
    this.fontWeight = FontWeight.w900,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: AppColors.textMainColor,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  FontWeight fontWeight;
  TextOverflow overFlow;

  TitleText({
    Key? key,
    this.color = AppColors.textBlack,
    required this.text,
    this.size = 20,
    this.fontWeight = FontWeight.w500,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SubTitleText({
    Key? key,
    this.color = AppColors.textGray,
    required this.text,
    this.size = 14,
    this.height = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
