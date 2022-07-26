import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/order_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/data/repo/all_product_repo.dart';
import 'package:onlineshop/data/repo/auth_repo.dart';
import 'package:onlineshop/data/repo/location_repo.dart';
import 'package:onlineshop/data/repo/order_repo.dart';
import 'package:onlineshop/data/repo/recommended_page_repo.dart';
import 'package:onlineshop/data/repo/cart_repo.dart';
import 'package:onlineshop/data/repo/product_repo.dart';
import 'package:onlineshop/data/repo/user_repo.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // Api Client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstans.baseUrl, sharedPreferences: Get.find()));

  // repos
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedPageRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => AllProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  // controller
  Get.lazyPut(() => RecommendedPageController(recommendedPageRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => AllProductController(allProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
