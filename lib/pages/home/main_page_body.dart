import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/models/products_model.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/icons_texts_widget.dart';
import 'package:onlineshop/widgets/title_text.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Article
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width20,
              top: Dimensions.height20,
              right: Dimensions.width20,
              bottom: Dimensions.height20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              TitleText(
                text: "RECOMMENDED",
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: TitleText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SubTitleText(text: "Recommended Product"),
              )
            ]),
          ),
        ),
        GetBuilder<RecommendedPageController>(builder: (recommendeds) {
          return recommendeds.isLoaded
              ? SizedBox(
                  height: Dimensions.height10 * 30,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: recommendeds.recommendedList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(
                          position, recommendeds.recommendedList[position]);
                    },
                  ),
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        // Slider dots
        GetBuilder<RecommendedPageController>(builder: (recommendeds) {
          return recommendeds.isLoaded
              ? DotsIndicator(
                  dotsCount: recommendeds.recommendedList.isEmpty
                      ? 1
                      : recommendeds.recommendedList.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )
              : Container();
        }),
        // Popular Section title
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TitleText(
              text: "POPULAR",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: TitleText(
                text: ".",
                color: Colors.black26,
              ),
            ),
            SizedBox(width: Dimensions.width10),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: SubTitleText(text: "Popular Product"),
            )
          ]),
        ),
        //list of recommended product
        GetBuilder<ProductController>(builder: (product) {
          return product.isLoaded
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height15,
                    horizontal: Dimensions.width30,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: product.productList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() {
                        Get.toNamed(RouteHelper.getProduct(index, "home"));
                      }),
                      child: Container(
                        height: Dimensions.height10 * 12,
                        margin: EdgeInsets.only(bottom: Dimensions.height15),
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                            color: AppColors.mainWhite,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 0.1,
                              )
                            ]),
                        child: Row(
                          children: [
                            // product image
                            Container(
                                width: Dimensions.width10 * 10,
                                height: Dimensions.height10 * 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstans.baseUrl +
                                          AppConstans.uploadUrl +
                                          product.productList[index].img)),
                                )),
                            //text product
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SubTitleText(
                                      text: product.productList[index].brand,
                                    ),
                                    TitleText(
                                      text: product.productList[index].name,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SubTitleText(
                                      text: product
                                          .productList[index].subcategory,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconsandTextWidget(
                                            icon: Icons.star,
                                            text: product
                                                .productList[index].stars
                                                .toString(),
                                            iconColor: AppColors.iconColor1),
                                        TitleText(
                                          text: CurrencyFormat.convertToIdr(
                                              product.productList[index].price,
                                              0),
                                          size: Dimensions.font16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
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
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel recommendedList) {
    // Matrix efek untuk slider
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor), 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          width: Dimensions.width10 * 32,
          height: Dimensions.height10 * 27,
          margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
          ),
          padding: EdgeInsets.all(Dimensions.height10),
          decoration: BoxDecoration(
              color: AppColors.mainWhite,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 20,
                  spreadRadius: -8,
                ),
              ]),
          child: Column(
            children: [
              GestureDetector(
                onTap: (() {
                  Get.toNamed(RouteHelper.getrecommended(index, "home"));
                }),
                child: Container(
                  width: Dimensions.width10 * 30,
                  height: Dimensions.height10 * 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: index.isEven
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFFd62828),
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(AppConstans.baseUrl +
                          AppConstans.uploadUrl +
                          recommendedList.img!),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.width15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: recommendedList.name!,
                            fontWeight: FontWeight.bold,
                          ),
                          SubTitleText(text: recommendedList.brand!),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
