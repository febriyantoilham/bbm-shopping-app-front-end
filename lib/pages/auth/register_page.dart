import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/models/register_model.dart';
import 'package:onlineshop/pages/auth/login_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_button.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();

  var _gender = "Male";

  @override
  Widget build(BuildContext context) {
    var emailController = _emailController;
    var passwordController = _passwordController;
    var nameController = _nameController;
    var genderController = _gender;
    var phoneController = _phoneController;
    var signUpImg = [
      "twitter.png",
      "facebook.png",
      "google.png",
    ];

    void registration(AuthController authController) {
      String name = nameController.text.trim();
      String gender = genderController.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        customSnackBar("Please input your name!", title: "Name is empty");
      } else if (gender.isEmpty) {
        customSnackBar("Please input your gender!", title: "Gender is empty");
      } else if (phone.isEmpty) {
        customSnackBar("Please input your phone number!",
            title: "Phone number is empty");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        customSnackBar("Your phone number is not valid!",
            title: "Phone number not valid");
      } else if (email.isEmpty) {
        customSnackBar("Please input your email!", title: "Email is empty");
      } else if (!GetUtils.isEmail(email)) {
        customSnackBar("Your email is not valid!", title: "Email not valid");
      } else if (password.isEmpty) {
        customSnackBar("Please input your password!",
            title: "password is empty");
      } else if (password.length < 6) {
        customSnackBar("Your password must be more than 6 characters",
            title: "Password is too sort");
      } else {
        RegisterModel registerModel = RegisterModel(
          name: name,
          gender: gender,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(registerModel).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getLogin());
            customSnackBar("Congrats your registration is success",
                title: "Registration Success", color: Colors.greenAccent);
          } else {
            customSnackBar(status.message);
          }
        });
      }
    }

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: Container(
          padding: EdgeInsets.only(top: Dimensions.statusBarWidth),
          width: Dimensions.screenWidth,
          child: GetBuilder<AuthController>(
            builder: ((authController) {
              return !authController.isLoading
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height45,
                            horizontal: Dimensions.width30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Icon
                            Center(
                              child: Container(
                                height: Dimensions.screenWidth * (50 / 100),
                                width: Dimensions.screenWidth * (50 / 100),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/registerui.png",
                                  ),
                                )),
                              ),
                            ),
                            SizedBox(height: Dimensions.height30),
                            SuperTitleText(text: "Sign Up"),
                            SizedBox(height: Dimensions.height20),
                            Column(
                              children: [
                                // Name
                                AppTextFieldPage(
                                  textController: _nameController,
                                  hintText: "Name",
                                  icon: Icons.person_outline_rounded,
                                  // color: AppColors.mainColor,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // Gender
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          setState(() {
                                            _gender = "Male";
                                          });
                                        },
                                        text: "Male",
                                        size: Dimensions.font16,
                                        bgColor: _gender == "Male"
                                            ? AppColors.backgroundButton
                                            : AppColors.backgroundWhite,
                                        textColor: _gender == "Male"
                                            ? AppColors.textWhite
                                            : AppColors.textGray,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                        child: AppButton(
                                      onTap: () {
                                        setState(() {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          _gender = "Female";
                                        });
                                      },
                                      text: "Female",
                                      size: Dimensions.font16,
                                      bgColor: _gender == "Female"
                                          ? AppColors.backgroundButton
                                          : AppColors.backgroundWhite,
                                      textColor: _gender == "Female"
                                          ? AppColors.textWhite
                                          : AppColors.textGray,
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // Phone
                                AppTextFieldPage(
                                  textController: _phoneController,
                                  hintText: "Phone",
                                  icon: Icons.phone_outlined,
                                  inputType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // Email
                                AppTextFieldPage(
                                  textController: _emailController,
                                  hintText: "Email",
                                  icon: Icons.email_outlined,
                                  // color: AppColors.mainColor,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // Password
                                AppTextFieldPage(
                                  textHide: _isObscure,
                                  textController: _passwordController,
                                  hintText: "Password",
                                  icon: Icons.lock_outline,
                                  suffixIcon: IconButton(
                                    onPressed: (() {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Sign Up button
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Column(
                              children: [
                                Container(
                                    width: 280,
                                    child: Text.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "By signing up, you’re agree to our ",
                                            style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: Dimensions.font14)),
                                        TextSpan(
                                            text: "Terms & Conditions",
                                            style: TextStyle(
                                                color: AppColors.textMainColor,
                                                fontSize: Dimensions.font14)),
                                        TextSpan(
                                            text: " and ",
                                            style: TextStyle(
                                                color: AppColors.textColor,
                                                fontSize: Dimensions.font14)),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                                color: AppColors.textMainColor,
                                                fontSize: Dimensions.font14)),
                                      ]),
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(
                                  height: Dimensions.height30,
                                ),
                                AppButton(
                                  onTap: (() {
                                    registration(authController);
                                  }),
                                  text: "Sign Up",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Have an account already? ",
                                        style: TextStyle(
                                          color: AppColors.textGray,
                                          fontSize: Dimensions.font16,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Get.off(
                                              () => LoginPage(),
                                              transition: Transition.fade),
                                        text: "Sign In",
                                        style: TextStyle(
                                            color: AppColors.textMainColor,
                                            fontSize: Dimensions.font16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : const CustomLoader();
            }),
          ),
        ),
      ),
    );
  }
}
