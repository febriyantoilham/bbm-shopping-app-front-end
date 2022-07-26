import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<RecommendedPageController>().getRecommendedList();
    await Get.find<ProductController>().getProductList();
    await Get.find<AllProductController>().getAllProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 2),
        // final user = UserEmail.getUserEmail();
        () {
      /* Using Firebase */
      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   Get.toNamed(RouteHelper.getInitial());
      // } else {
      //   Get.toNamed(RouteHelper.getLogin());
      // }
      /* Using Localhost */
      if (Get.find<AuthController>().userLoggedIn()) {
        Get.offNamed(RouteHelper.getInitial());
      } else {
        Get.offNamed(RouteHelper.getStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: Center(
            child: Image.asset(
          "assets/images/logo.png",
          height: Dimensions.screenHeight / (Dimensions.screenHeight / 150),
        )));
  }
}
