import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_button.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  OrderSuccessPage({Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), (() {}));
    }
    return Scaffold(
      backgroundColor: status == 1 ? AppColors.mainColor : Colors.redAccent,
      body: Center(
        child: SizedBox(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    status == 1
                        ? Image.asset("assets/images/successui.png",
                            width: Dimensions.screenWidth /
                                (Dimensions.screenWidth / 200))
                        : Container(),
                    // Image.asset(name)
                    SizedBox(height: Dimensions.height20),
                    TitleText(
                      text: status == 1 ? "Congratulations." : "I'm Sorry!",
                      size: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainWhite,
                    ),
                    TitleText(
                      text: status == 1
                          ? "Your order is Succesful!"
                          : "Your payment is failed",
                      size: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainWhite,
                    ),
                    SizedBox(height: Dimensions.height30),
                    TitleText(
                      text:
                          status == 1 ? "You have successfully made order" : "",
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
                      color:
                          status == 1 ? AppColors.mainColor : Colors.redAccent,
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
