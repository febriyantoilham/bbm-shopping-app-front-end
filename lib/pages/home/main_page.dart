import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/pages/home/main_page_body.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final int pageId = 0;

  Future<void> _loadResource() async {
    await Get.find<RecommendedPageController>().getRecommendedList();
    await Get.find<ProductController>().getProductList();
    await Get.find<AllProductController>().getAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().productList[pageId];
    Get.find<RecommendedPageController>()
        .initRecommended(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        padding: EdgeInsets.only(top: Dimensions.statusBarWidth),
        width: Dimensions.screenWidth,
        child: RefreshIndicator(
            onRefresh: _loadResource,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height10, bottom: Dimensions.height10),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Dimensions.height100,
                        height: Dimensions.width45,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.cover)),
                      ),
                      GetBuilder<RecommendedPageController>(
                          builder: ((controller) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.cart);
                          },
                          child: Stack(
                            children: [
                              AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                size: Dimensions.height45,
                                bgColor: Colors.transparent,
                                icColor: AppColors.iconBlack,
                                iconSize: Dimensions.height30,
                              ),
                              controller.totalItems >= 1
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: AppIcon(
                                        icon: Icons.circle,
                                        size: Dimensions.height20,
                                        icColor: Colors.transparent,
                                        bgColor: AppColors.iconColor1,
                                      ),
                                    )
                                  : Container(),
                              Get.find<RecommendedPageController>()
                                          .totalItems >=
                                      1
                                  ? Positioned(
                                      right: 6,
                                      top: 3,
                                      child: TitleText(
                                        text: Get.find<
                                                RecommendedPageController>()
                                            .totalItems
                                            .toString(),
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      }))
                    ],
                  ),
                ),
                // body section
                const Expanded(
                    child: SingleChildScrollView(
                  child: MainPageBody(),
                ))
              ],
            )),
      ),
    );
  }
}
