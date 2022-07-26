import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/pages/auth/register_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_button.dart';
import 'package:onlineshop/widgets/title_text.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: Container(
          padding: EdgeInsets.only(top: Dimensions.statusBarWidth),
          width: Dimensions.screenWidth,
          child: GetBuilder<AuthController>(builder: (authController) {
            return !authController.isLoading
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Icon
                        Center(
                          child: Container(
                            height: Dimensions.screenWidth * (60 / 100),
                            width: Dimensions.screenWidth * (60 / 100),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/registerui.png"),
                              ),
                            ),
                          ),
                        ),
                        // Opening Text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Dimensions.screenWidth * (50 / 100),
                                child:
                                    SuperTitleText(text: "Let's Get Started")),
                            SizedBox(
                              width: Dimensions.screenWidth * (60 / 100),
                              child: SubTitleText(
                                text:
                                    "Explorer everything you need to find your best order.",
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        // Button
                        Column(
                          children: [
                            AppButton(
                              onTap: () {
                                Get.toNamed(RouteHelper.getSignUp());
                              },
                              text: "Create an Account",
                              bgColor: AppColors.backgroundButton,
                              textColor: AppColors.textWhite,
                              borderColor: Colors.transparent,
                            ),
                            SizedBox(height: Dimensions.height20),
                            GestureDetector(
                                onTap: (() {
                                  Get.toNamed(RouteHelper.getLogin());
                                }),
                                child: AppButton(
                                  text: "Sign In",
                                  bgColor: AppColors.backgroundButton,
                                  textColor: AppColors.textWhite,
                                  borderColor: Colors.transparent,
                                )),
                          ],
                        ),
                        // SizedBox(height: Dimensions.height10),
                      ],
                    ),
                  )
                : const CustomLoader();
          }),
        ));
  }
}

class SocialAuth extends StatelessWidget {
  SocialAuth({
    Key? key,
    required this.image,
    required this.bgColor,
  }) : super(key: key);

  AssetImage image;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.height10),
      padding: EdgeInsets.all(Dimensions.height10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ]),
      child: CircleAvatar(
        radius: Dimensions.height15,
        backgroundImage: image,
        backgroundColor: bgColor,
      ),
    );
  }
}
