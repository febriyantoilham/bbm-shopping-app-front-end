// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/pages/auth/register_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_button.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var emailController = _emailController;
    var passwordController = _passwordController;

    void login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        customSnackBar("Please input your email account!",
            title: "Email Account is empty");
      } else if (password.isEmpty) {
        customSnackBar("Please input your password!",
            title: "password is empty");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
            customSnackBar("Login Success",
                title: "Welcome Back", color: Colors.greenAccent);
          } else {
            customSnackBar(status.message);
          }
        });
      }
    }

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
          backgroundColor: AppColors.secondaryColor,
          body: Container(
            padding: EdgeInsets.only(top: Dimensions.statusBarWidth),
            width: Dimensions.screenWidth,
            child: GetBuilder<AuthController>(builder: (authController) {
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
                                  image:
                                      AssetImage("assets/images/loginui.png"),
                                )),
                              ),
                            ),
                            SizedBox(height: Dimensions.height30),
                            SuperTitleText(text: "Login"),
                            SizedBox(height: Dimensions.height20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Email
                                AppTextFieldPage(
                                  textController: _emailController,
                                  hintText: "Email",
                                  icon: Icons.alternate_email,
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
                                  icon: Icons.lock_outline_rounded,
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
                                  // color: AppColors.mainColor,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // Forgot Password
                                GestureDetector(
                                  onTap: () {},
                                  child: TitleText(
                                    text: "Forgot Password?",
                                    size: Dimensions.font16,
                                    color: AppColors.textGray,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Column(
                              children: [
                                AppButton(
                                  onTap: () {
                                    login(authController);
                                  },
                                  text: "Login",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Don't have an account? ",
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
                                              () => const RegisterPage(),
                                              transition: Transition.fade),
                                        text: "Sign Up",
                                        style: TextStyle(
                                          color: AppColors.textMainColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: Dimensions.font16,
                                        ),
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
          )),
    );
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
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
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
