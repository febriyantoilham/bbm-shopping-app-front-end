import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/data/repo/all_product_repo.dart';
import 'package:onlineshop/pages/home/main_page_body.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/icons_texts_widget.dart';
import 'package:onlineshop/widgets/title_text.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({Key? key}) : super(key: key);

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  Future<void> _loadResource() async {
    await Get.find<AllProductController>().getAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: RefreshIndicator(
          onRefresh: _loadResource,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height20,
                      horizontal: Dimensions.width20),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(
                              text: "Catalogue",
                              size: Dimensions.font26,
                              fontWeight: FontWeight.w500,
                            ),
                          ]),
                      SizedBox(height: Dimensions.height20),
                      //list of recommended product
                      GetBuilder<AllProductController>(builder: (product) {
                        return product.isLoaded
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: product.allproductList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (() {
                                      Get.toNamed(RouteHelper.getAllProduct(
                                          index, "home"));
                                    }),
                                    child: Container(
                                      // height: Dimensions.height10 * 12,
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      padding:
                                          EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                          color: AppColors.mainWhite,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              blurRadius: 0.1,
                                            )
                                          ]),
                                      child: Row(
                                        children: [
                                          // product image
                                          Container(
                                              width: Dimensions.width50,
                                              height: Dimensions.height50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15),
                                                color: Colors.white38,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstans.baseUrl +
                                                            AppConstans
                                                                .uploadUrl +
                                                            product
                                                                .allproductList[
                                                                    index]
                                                                .img)),
                                              )),
                                          //text product
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SubTitleText(
                                                      text: product
                                                          .allproductList[index]
                                                          .brand),
                                                  TitleText(
                                                    text: product
                                                        .allproductList[index]
                                                        .name,
                                                    size: Dimensions.font16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const CircularProgressIndicator(
                                color: AppColors.mainColor,
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
