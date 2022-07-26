import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/base/no_data_page.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/order_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/models/place_order_model.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({Key? key}) : super(key: key);

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPagePageState();
}

class _PaymentOptionPagePageState extends State<PaymentOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
        padding: EdgeInsets.all(Dimensions.height20),
        child: Column(
          children: [
            /* Top Bar */
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
                  text: "Payment Methods",
                  fontWeight: FontWeight.w800,
                  size: Dimensions.font20,
                ),
              ],
            ),
            SizedBox(height: Dimensions.height20),
            /* Payment Method */
            GetBuilder<OrderController>(builder: (orderController) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: "Select the payment method you want to use",
                      color: AppColors.mainIcon,
                      size: Dimensions.font16,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: Dimensions.height20),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderController.paymentList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (() {
                            orderController.setPaymentSelectedIndex(index);
                          }),
                          child: Column(
                            children: [
                              Container(
                                // height: Dimensions.height100,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height15),
                                padding: EdgeInsets.all(Dimensions.height10),
                                decoration: BoxDecoration(
                                    color: AppColors.mainWhite,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    border: Border.all(
                                        color: orderController
                                                    .paymentSelectedIndex ==
                                                index
                                            ? AppColors.mainIcon
                                            : Colors.transparent),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 0.1,
                                      )
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.height20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Address Icon
                                          TitleText(
                                            text: orderController
                                                .paymentList[index],
                                            fontWeight: FontWeight.bold,
                                            size: Dimensions.font16,
                                          ),
                                          SizedBox(height: Dimensions.height5),
                                          Icon(
                                            orderController
                                                        .paymentSelectedIndex ==
                                                    index
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color: AppColors.mainIcon,
                                          )
                                        ],
                                      ),
                                      orderController.paymentSelectedIndex ==
                                              index
                                          ? Container(
                                              // height: 100,
                                              width: Dimensions.screenWidth,
                                              decoration: BoxDecoration(
                                                color: AppColors.mainWhite,
                                              ),
                                              child: orderController
                                                          .paymentSelectedIndex ==
                                                      0
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            height: Dimensions
                                                                .height10),
                                                        SubTitleText(
                                                          text:
                                                              "Manual confirmation",
                                                        ),
                                                      ],
                                                    )
                                                  : orderController
                                                              .paymentSelectedIndex ==
                                                          1
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height10),
                                                            SubTitleText(
                                                              text:
                                                                  "Auto confirmation",
                                                            ),
                                                          ],
                                                        )
                                                      : Container())
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]);
            }),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: ((controller) {
        var cartList = controller.getItems;
        return Container(
          height: Dimensions.screenHeight / (Dimensions.screenHeight / 100),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20,
            vertical: Dimensions.height20 + 5,
          ),

          // Bottom Bar
          child: GetBuilder<LocationController>(builder: (locationController) {
            return GestureDetector(
              onTap: () {
                // print("Tapped");
                // controller.addToHistory();
                // Get.toNamed(RouteHelper.getCheckout());
                if (Get.find<AuthController>().userLoggedIn()) {
                  if (locationController.addressList.isEmpty) {
                    Get.toNamed(RouteHelper.getAddress());
                  } else {
                    var location = locationController.addressList;
                    var cart = Get.find<CartController>().getItems;
                    var user = Get.find<UserController>().userModel;
                    PlaceOrderBody placeOrder = PlaceOrderBody(
                      cart: cart,
                      orderAmount: 1,
                      paymentMethod:
                          Get.find<OrderController>().paymentSelectedIndex == 0
                              ? "Transfer Bank"
                              : "",
                      orderNote: "The Product",
                      address: locationController
                          .addressList[locationController.addressSelectedIndex]
                          .address,
                      latitude: locationController
                          .addressList[locationController.addressSelectedIndex]
                          .latitude,
                      longitude: locationController
                          .addressList[locationController.addressSelectedIndex]
                          .longitude,
                      contactPersonName: user!.name,
                      contactPersonNumber: user.phone,
                      scheduleAt: '',
                      distance: 10.0,
                    );
                    print(placeOrder.orderAmount);
                    Get.find<OrderController>()
                        .placeOrder(placeOrder, _callBack);
                  }
                } else {
                  Get.toNamed(RouteHelper.getLogin());
                }
              },
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: TitleText(
                    text: "Order Now",
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
        );
      })),
    );
  }

  void _callBack(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreferences();
      Get.find<CartController>().addToHistory();
      Get.find<OrderController>().paymentSelectedIndex == 0
          ? Get.offNamed(RouteHelper.getOrderSuccessManual())
          : Get.offNamed(RouteHelper.getPaymentPage(
              orderID, Get.find<UserController>().userModel!.id));
      // Get.offNamed(RouteHelper.getInitial());
    } else {
      customSnackBar("message");
    }
  }
}
