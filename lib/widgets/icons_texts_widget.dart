import 'package:flutter/cupertino.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class IconsandTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconsandTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.icon24,
        ),
        const SizedBox(
          width: 5,
        ),
        SubTitleText(
          text: text,
        ),
      ],
    );
  }
}
