import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/base/no_data_page.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_button.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
        padding: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10),
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
                    text: "Checkout Order",
                    fontWeight: FontWeight.w700,
                    size: Dimensions.font20,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height20),
              /* Shipping Address */
              GetBuilder<LocationController>(builder: (address) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: "Shipping Address",
                      color: AppColors.mainIcon,
                      size: Dimensions.font18,
                      fontWeight: FontWeight.w500,
                    ),
                    address.addressList.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height15,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // height: Dimensions.height100,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    padding:
                                        EdgeInsets.all(Dimensions.height10),
                                    decoration: BoxDecoration(
                                        color: AppColors.mainWhite,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            blurRadius: 0.1,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.height20),
                                      child: Row(
                                        children: [
                                          // Address Icon
                                          Column(
                                            children: [
                                              TitleText(
                                                text: address
                                                    .addressList[address
                                                        .addressSelectedIndex]
                                                    .addressType,
                                                size: Dimensions.font16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                  height: Dimensions.height5),
                                              AppIcon(
                                                icon: address
                                                            .addressList[address
                                                                .addressSelectedIndex]
                                                            .addressType ==
                                                        "Home"
                                                    ? Icons.home
                                                    : address
                                                                .addressList[address
                                                                    .addressSelectedIndex]
                                                                .addressType ==
                                                            "Office"
                                                        ? Icons.work
                                                        : Icons.location_on,
                                                size: Dimensions.height50,
                                                iconSize: Dimensions.height30,
                                                bgColor: AppColors.mainIcon,
                                                icColor: AppColors.mainWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: Dimensions.width20),
                                          //text product
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TitleText(
                                                  text:
                                                      "${address.addressList[address.addressSelectedIndex].contactPersonName}",
                                                  size: Dimensions.font14,
                                                  color: AppColors.textColor,
                                                ),
                                                SizedBox(
                                                    height: Dimensions.height5),
                                                TitleText(
                                                  text:
                                                      "${address.addressList[address.addressSelectedIndex].contactPersonNumber}",
                                                  size: Dimensions.font14,
                                                  color: AppColors.textColor,
                                                ),
                                                SizedBox(
                                                    height: Dimensions.height5),
                                                TitleText(
                                                  text: address
                                                      .addressList[address
                                                          .addressSelectedIndex]
                                                      .address,
                                                  size: Dimensions.font14,
                                                  color: AppColors.textColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.chooseAddress);
                                    },
                                    child: TitleText(
                                      text: "Edit Address",
                                      color: AppColors.mainColor,
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getChooseAddress());
                            },
                            child: Center(
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: Dimensions.height20),
                                width: double.maxFinite,
                                height: Dimensions.height50 - 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: AppColors.mainWhite,
                                  border:
                                      Border.all(color: AppColors.mainColor),
                                ),
                                child: Center(
                                  child: TitleText(
                                    text: "Add Address",
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                    size: Dimensions.font16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              }),
              /* AddressList */
              SizedBox(height: Dimensions.height20),
              /* Product List */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: "Order List",
                    color: AppColors.mainIcon,
                    size: Dimensions.font18,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: Dimensions.height20),
                  GetBuilder<CartController>(builder: (cartController) {
                    return cartController.getItems.isNotEmpty
                        ? MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: ((controller) {
                              var cartList = controller.getItems;
                              return ListView.builder(
                                itemCount: cartList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  return Container(
                                    width: double.maxFinite,
                                    padding:
                                        EdgeInsets.all(Dimensions.height10),
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15),
                                        border: Border.all(
                                            color: Colors.black
                                                .withOpacity(0.10))),
                                    child: Row(
                                      children: [
                                        /* Gambar Produk */
                                        Container(
                                          width: Dimensions.height80,
                                          height: Dimensions.height80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstans.baseUrl +
                                                      AppConstans.uploadUrl +
                                                      controller.getItems[index]
                                                          .img!),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width20),
                                        /* Product Description */
                                        Expanded(
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SubTitleText(
                                                      text: controller
                                                          .getItems[index].brand
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width5),
                                                    SubTitleText(text: "-"),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width5),
                                                    Expanded(
                                                      child: TitleText(
                                                        text: controller
                                                            .getItems[index]
                                                            .name!,
                                                        size: Dimensions.font16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    TitleText(
                                                      text: cartList[index]
                                                          .quantity
                                                          .toString(),
                                                      size: Dimensions.font16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    SubTitleText(
                                                      text: " Item",
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          TitleText(
                                                            text: CurrencyFormat.convertToIdr(
                                                                controller
                                                                        .getItems[
                                                                            index]
                                                                        .price! *
                                                                    cartList[
                                                                            index]
                                                                        .quantity!,
                                                                0),
                                                            size: Dimensions
                                                                .font16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .width5),
                                                          SubTitleText(
                                                            text: "total",
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              );
                            })))
                        : const NoDataPage(text: "Keranjang Kamu Kosong");
                  }),
                ],
              ),
              /* Product list*/
              SizedBox(height: Dimensions.height20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: ((controller) {
        var cartList = controller.getItems;
        return Container(
          height: cartList.isEmpty
              ? 0
              : Dimensions.screenHeight / (Dimensions.screenHeight / 150),
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height30,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius15),
                topRight: Radius.circular(Dimensions.radius15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                )
              ],
              color: AppColors.secondaryColor),
          // Bottom Bar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(
                      text: "Total",
                      size: Dimensions.font18,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        SubTitleText(text: "(${controller.totalItems} Items)"),
                        SizedBox(width: Dimensions.width10),
                        TitleText(
                          text: CurrencyFormat.convertToIdr(
                              controller.totalAmount, 0),
                          size: Dimensions.font18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: GetBuilder<LocationController>(
                    builder: (locationController) {
                  return AppButton(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCheckout());
                      if (Get.find<AuthController>().userLoggedIn()) {
                        if (locationController.addressList.isEmpty) {
                          customSnackBar("Please add your shipping address!",
                              title: "Your address is still empty");
                        } else {
                          Get.toNamed(RouteHelper.getPaymentOption());
                        }
                      } else {
                        Get.toNamed(RouteHelper.getLogin());
                      }
                    },
                    text: "Payment",
                  );
                }),
              )
            ],
          ),
        );
      })),
    );
  }
}
