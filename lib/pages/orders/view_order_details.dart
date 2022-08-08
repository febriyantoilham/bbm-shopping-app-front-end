import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlineshop/controller/order_controller.dart';
import 'package:onlineshop/models/order_detail_model.dart';
import 'package:onlineshop/models/order_model.dart';
import 'package:onlineshop/models/place_order_model.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_button.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ViewOrderDetails extends StatefulWidget {
  const ViewOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetails> createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  Future<void> _loadResource() async {
    await Get.find<OrderController>().getOrderList();
    await Get.find<OrderController>().getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: _loadResource,
          child: GetBuilder<OrderController>(builder: (orderController) {
            return Container(
              margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
              padding: EdgeInsets.all(Dimensions.height20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        text: "Order Detail",
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20,
                                vertical: Dimensions.height20),
                            decoration: BoxDecoration(
                                color: AppColors.mainWhite,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: "Order Status : ",
                                      size: Dimensions.font14,
                                    ),
                                    TitleText(
                                      text: orderController
                                          .selectedOrder.orderStatus
                                          .toString()
                                          .toUpperCase(),
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.bold,
                                      color: orderController
                                                  .selectedOrder.orderStatus ==
                                              "waiting"
                                          ? Colors.black
                                          : orderController.selectedOrder
                                                      .orderStatus ==
                                                  "pending"
                                              ? AppColors.iconColor1
                                              : orderController.selectedOrder
                                                          .orderStatus ==
                                                      "canceled"
                                                  ? AppColors.iconColor3
                                                  : AppColors.mainColor,
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.25),
                                  height: Dimensions.height30,
                                  thickness: 0.5,
                                ),
                                SubTitleText(
                                  text: "#${orderController.selectedOrder.id}",
                                  size: Dimensions.font14,
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SubTitleText(
                                      text: "Order Date",
                                      size: Dimensions.font14,
                                    ),
                                    TitleText(
                                      text: DateFormat.yMMMMd().add_jm().format(
                                          DateTime.parse(orderController
                                              .selectedOrder.createdAt
                                              .toString())),
                                      size: Dimensions.font14,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          Container(
                            width: Dimensions.screenWidth,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20,
                                vertical: Dimensions.height20),
                            decoration: BoxDecoration(
                                color: AppColors.mainWhite,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(
                                  text: "Product Detail",
                                  size: Dimensions.font16,
                                  fontWeight: FontWeight.bold,
                                ),
                                Container(
                                  width: Dimensions.screenWidth,
                                  margin: EdgeInsets.symmetric(
                                      vertical: Dimensions.height5),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: orderController
                                          .currentOrderDetail.length,
                                      itemBuilder: ((context, index) {
                                        return orderController
                                                    .currentOrderDetail[index]
                                                    .orderId ==
                                                orderController.selectedOrder.id
                                            ? Container(
                                                width: double.maxFinite,
                                                margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        Dimensions.height5),
                                                padding: EdgeInsets.all(
                                                    Dimensions.height10),
                                                decoration: BoxDecoration(
                                                    color: AppColors.mainWhite,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 1,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius15)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: Dimensions
                                                              .height60,
                                                          width: Dimensions
                                                              .width60,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(AppConstans.baseUrl +
                                                                      AppConstans
                                                                          .uploadUrl +
                                                                      orderController
                                                                          .currentOrderDetail[
                                                                              index]
                                                                          .productDetails!
                                                                          .img!))),
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .width5),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SubTitleText(
                                                                  text: orderController
                                                                      .currentOrderDetail[
                                                                          index]
                                                                      .productDetails!
                                                                      .brand!),
                                                              TitleText(
                                                                text: orderController
                                                                    .currentOrderDetail[
                                                                        index]
                                                                    .productDetails!
                                                                    .name!,
                                                                size: Dimensions
                                                                    .font14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              TitleText(
                                                                text:
                                                                    "${orderController.currentOrderDetail[index].quantity} x ${CurrencyFormat.convertToIdr(orderController.currentOrderDetail[index].productDetails!.price, 0)}",
                                                                size: Dimensions
                                                                    .font14,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      height:
                                                          Dimensions.height30,
                                                      thickness: 0.5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SubTitleText(
                                                                text: "Total"),
                                                            TitleText(
                                                              text: CurrencyFormat
                                                                  .convertToIdr(
                                                                      orderController
                                                                          .currentOrderDetail[
                                                                              index]
                                                                          .price,
                                                                      0),
                                                              size: Dimensions
                                                                  .font14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            : SizedBox();
                                      })),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(Dimensions.height20),
                            decoration: BoxDecoration(
                              color: AppColors.mainWhite,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(
                                  text: "Delivery Address",
                                  size: Dimensions.font16,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: Dimensions.height20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(
                                      text: "Address :",
                                      size: Dimensions.font14,
                                    ),
                                    SizedBox(width: Dimensions.width30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TitleText(
                                            text: orderController
                                                .selectedOrder
                                                .deliveryAddress!
                                                .contactPersonName!,
                                            size: Dimensions.font14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          TitleText(
                                            text: orderController
                                                .selectedOrder
                                                .deliveryAddress!
                                                .contactPersonNumber!,
                                            size: Dimensions.font14,
                                          ),
                                          Container(
                                            width: double.maxFinite,
                                            child: Text(
                                              orderController.selectedOrder
                                                  .deliveryAddress!.address,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: Dimensions.font14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(Dimensions.height20),
                            decoration: BoxDecoration(
                              color: AppColors.mainWhite,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: "Order Summary",
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    TitleText(
                                      text: orderController
                                          .selectedOrder.paymentStatus
                                          .toString()
                                          .toUpperCase(),
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.bold,
                                      color: orderController.selectedOrder
                                                  .paymentStatus ==
                                              "unpaid"
                                          ? AppColors.iconColor3
                                          : AppColors.mainColor,
                                    )
                                  ],
                                ),
                                SizedBox(height: Dimensions.height20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SubTitleText(
                                        text: "Payment Method",
                                        size: Dimensions.font14),
                                    TitleText(
                                        text: orderController
                                            .selectedOrder.paymentMethod!
                                            .toUpperCase(),
                                        size: Dimensions.font14),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.25),
                                  height: Dimensions.height30,
                                  thickness: 0.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SubTitleText(
                                        text: "Order Amount",
                                        size: Dimensions.font14),
                                    TitleText(
                                        text: CurrencyFormat.convertToIdr(
                                            orderController
                                                .selectedOrder.orderAmount,
                                            0),
                                        size: Dimensions.font14),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SubTitleText(
                                        text: "Delivery Charge",
                                        size: Dimensions.font14),
                                    TitleText(
                                        text: CurrencyFormat.convertToIdr(
                                            orderController
                                                .selectedOrder.deliveryCharge,
                                            0),
                                        size: Dimensions.font14),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.25),
                                  height: Dimensions.height30,
                                  thickness: 0.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: "Total",
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    TitleText(
                                      text: CurrencyFormat.convertToIdr(
                                          orderController.selectedOrder
                                                  .deliveryCharge! +
                                              orderController
                                                  .selectedOrder.orderAmount!,
                                          0),
                                      size: Dimensions.font16,
                                      fontWeight: FontWeight.w700,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GetBuilder<OrderController>(builder: (orderController) {
              return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height15),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25), blurRadius: 10)
                    ],
                  ),
                  child:
                      orderController.selectedOrder.orderStatus == "Delivered"
                          ? AppButton(
                              onTap: () {},
                              text: "Selesaikan Pesanan",
                            )
                          : AppButton(text: "Bantuan"));
            }))
      ]),
    );
  }
}
