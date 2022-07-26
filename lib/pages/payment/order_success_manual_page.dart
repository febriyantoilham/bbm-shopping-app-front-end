import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_button.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class OrderSuccessPageManual extends StatelessWidget {
  OrderSuccessPageManual({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: SizedBox(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/successui.png",
                      width: Dimensions.screenWidth /
                          (Dimensions.screenWidth / 200),
                    ),
                    SizedBox(height: Dimensions.height20),
                    TitleText(
                      text: "Congratulations.",
                      size: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainWhite,
                    ),
                    TitleText(
                      text: "Your order is Succesful!",
                      size: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainWhite,
                    ),
                    SizedBox(height: Dimensions.height30),
                    TitleText(
                      text: "You have successfully made order",
                      size: Dimensions.font16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainWhite,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.offAllNamed(RouteHelper.getInitial()),
                  child: Container(
                    width: Dimensions.screenWidth,
                    height: Dimensions.height50,
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                        color: AppColors.mainWhite,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20 + 5)),
                    child: Center(
                        child: TitleText(
                      text: "Back To Home",
                      size: Dimensions.font18,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
