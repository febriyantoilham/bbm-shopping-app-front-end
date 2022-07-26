import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'helper/dependencies.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  // var DefaultFirebaseOptions;
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>()
        .getCartData(); /* this how to load some storage or shared preference */

    /* this below code for keep memories from splash screen */
    return GetBuilder<AllProductController>(builder: (_) {
      return GetBuilder<RecommendedPageController>(builder: (_) {
        return GetBuilder<ProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // home: const LoginPage(),
            // home: SplashScreen(),
            initialRoute: RouteHelper.getSplash(),
            getPages: RouteHelper.routes,
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
            ),
          );
        });
      });
    });
  }
}
