import 'package:flutter/material.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ExpandebleTextWidget extends StatefulWidget {
  final String text;

  const ExpandebleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandebleTextWidget> createState() => _ExpendableTextWidgetState();
}

class _ExpendableTextWidgetState extends State<ExpandebleTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.height100;

  @override
  void initState() {
    super.initState();
    // Check text length code
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SubTitleText(
              height: 1.8,
              size: Dimensions.font14,
              text: firstHalf,
            )
          : Column(
              children: [
                SubTitleText(
                    height: 1.8,
                    size: Dimensions.font14,
                    text: hiddenText
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SubTitleText(
                          text: hiddenText ? "Show more" : "Show less",
                          color: AppColors.mainColor),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
