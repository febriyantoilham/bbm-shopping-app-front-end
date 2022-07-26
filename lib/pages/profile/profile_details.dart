import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var genderController = TextEditingController();

    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

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
                    text: "Profile",
                    fontWeight: FontWeight.w800,
                    size: Dimensions.font20,
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20),
              GetBuilder<UserController>(builder: (userController) {
                emailController.text = userController.userModel!.email;
                nameController.text = userController.userModel!.name;
                phoneController.text = userController.userModel!.phone;
                genderController.text = userController.userModel!.gender;
                return userLoggedIn
                    ? (userController.isLoading
                        ? Container(
                            width: double.maxFinite,
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
                                SizedBox(
                                  height: Dimensions.height30,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      // Email
                                      AppTextFieldPage(
                                        textController: emailController,
                                        hintText: "Email",
                                        icon: Icons.email_outlined,
                                        enable: false,
                                        // readOnly: true,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      // Name
                                      AppTextFieldPage(
                                        textController: nameController,
                                        hintText: "Name",
                                        icon: Icons.person_outline,
                                        enable: false,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      // Phone
                                      AppTextFieldPage(
                                        textController: phoneController,
                                        hintText: "Phone",
                                        icon: Icons.phone_outlined,
                                        enable: false,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      AppTextFieldPage(
                                        textController: genderController,
                                        hintText: "Gender",
                                        icon: Icons.male_outlined,
                                        enable: false,
                                      ),
                                    ],
                                  ),
                                ),

                                // Container(
                                //   margin: EdgeInsets.symmetric(
                                //       horizontal: Dimensions.width15),
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: Dimensions.height15,
                                //       horizontal: Dimensions.width15),
                                //   width: double.maxFinite,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(10),
                                //     boxShadow: [
                                //       BoxShadow(
                                //           blurRadius: 1,
                                //           spreadRadius: 1,
                                //           color: Colors.grey.withOpacity(0.25))
                                //     ],
                                //   ),
                                //   child: SingleChildScrollView(
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         TitleText(
                                //           text: "Personal Information",
                                //           size: Dimensions.font20,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //         SizedBox(height: Dimensions.height20),
                                //         Row(
                                //           children: [
                                //             const ProfileLabel(
                                //               text: 'Name',
                                //             ),
                                //             ProfileText(
                                //               text: userController.userModel.name,
                                //             ),
                                //           ],
                                //         ),
                                //         SizedBox(height: Dimensions.height15),
                                //         Row(
                                //           children: [
                                //             const ProfileLabel(
                                //               text: 'Email',
                                //             ),
                                //             ProfileText(
                                //               text: userController.userModel.email,
                                //             ),
                                //           ],
                                //         ),
                                //         SizedBox(height: Dimensions.height15),
                                //         Row(
                                //           children: [
                                //             const ProfileLabel(
                                //               text: 'Phone',
                                //             ),
                                //             ProfileText(
                                //               text: userController.userModel.phone,
                                //             ),
                                //           ],
                                //         ),
                                //         SizedBox(height: Dimensions.height15),
                                //         Row(
                                //           children: const [
                                //             ProfileLabel(
                                //               text: 'Address',
                                //             ),
                                //             ProfileText(
                                //               text: "User Address",
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        : const CustomLoader())
                    : const SnackBar(
                        content: Text("Please Login to see your profile"),
                        backgroundColor: Colors.red,
                      );
              }),
            ],
          ),
        ));
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    );
  }
}

class ProfileLabel extends StatelessWidget {
  const ProfileLabel({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.screenWidth / 4,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 15,
        ),
      ),
    );
  }
}
