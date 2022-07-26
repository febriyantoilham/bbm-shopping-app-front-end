import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back,
                    icColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                TitleText(
                  text: "Help Center",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            SizedBox(height: Dimensions.height20),
            SingleChildScrollView(
              child: Column(
                children: const [
                  SupportItem(
                    icon: Icons.support_agent_outlined,
                    text: "Customer Services",
                  ),
                  SupportItem(icon: Icons.whatsapp, text: "Whatsapp"),
                  SupportItem(icon: Icons.facebook_outlined, text: "Facebook")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SupportItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const SupportItem(
      {Key? key, required this.icon, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.height50,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 0.1)
            ]),
        child: Row(
          children: [
            AppIcon(
              icon: icon,
              bgColor: Colors.transparent,
              iconSize: Dimensions.height30,
              icColor: AppColors.iconBlue,
            ),
            SizedBox(width: Dimensions.width15),
            TitleText(
              text: text,
              size: Dimensions.font16,
            ),
          ],
        ),
      ),
    );
  }
}
