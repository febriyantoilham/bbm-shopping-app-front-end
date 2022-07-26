import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/profile_widget.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Container(
          margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
          padding: EdgeInsets.all(
            Dimensions.width20,
          ),
          child: GetBuilder<UserController>(builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        // margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //Profile Icon
                            AppIcon(
                              icon: Icons.person_outline_rounded,
                              bgColor: AppColors.mainIcon,
                              icColor: Colors.white,
                              iconSize: Dimensions.screenWidth /
                                  (Dimensions.screenWidth / 80),
                              size: Dimensions.screenWidth /
                                  (Dimensions.screenWidth / 100),
                            ),
                            SizedBox(height: Dimensions.height20),
                            TitleText(
                              text: userController.userModel!.name,
                              size: Dimensions.font26,
                              fontWeight: FontWeight.w700,
                            ),
                            Divider(
                              height: Dimensions.height60,
                              thickness: 1,
                              indent: Dimensions.width20,
                              endIndent: Dimensions.width20,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //My Account
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.toNamed(
                                              RouteHelper.getProfileDetails());
                                        }
                                      },
                                      child: ProfileWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.person_outline_rounded,
                                          bgColor: Colors.transparent,
                                          icColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                        ),
                                        titleText: TitleText(
                                          text: "Personal Information",
                                          size: Dimensions.font18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    //My Address
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          RouteHelper.getAddress(),
                                        );
                                      },
                                      child: ProfileWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.pin_drop_outlined,
                                          bgColor: Colors.white.withOpacity(0),
                                          icColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                        ),
                                        titleText: TitleText(
                                          text: "Address",
                                          size: Dimensions.font18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),

                                    //Support
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getSupportPage());
                                      },
                                      child: ProfileWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.contact_support_outlined,
                                          bgColor: Colors.white.withOpacity(0),
                                          icColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                        ),
                                        titleText: TitleText(
                                          text: "Help Center",
                                          size: Dimensions.font18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    //Logout
                                    GestureDetector(
                                      onTap: ((() async {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearShareData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.find<LocationController>()
                                              .clearAddressList();
                                          Get.offNamed(RouteHelper.getLogin());
                                        }
                                      })),
                                      child: ProfileWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          bgColor: Colors.white.withOpacity(0),
                                          icColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                        ),
                                        titleText: TitleText(
                                          text: "Logout",
                                          size: Dimensions.font18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const CustomLoader())
                : const SnackBar(
                    content: Text("Please Login to see your profile"),
                    backgroundColor: Colors.red,
                  );
          }),
        ));
  }
}
