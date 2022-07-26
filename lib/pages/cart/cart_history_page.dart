// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlineshop/base/no_data_page.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/models/cart_model.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var output = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm:ss");
        var output = outputFormat.format(inputDate);
      }
      return TitleText(
        text: output,
        size: Dimensions.font16 + 2,
        fontWeight: FontWeight.w500,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          /* Body */
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(children: [
                          for (int i = 0; i < itemsPerOrder.length; i++)
                            Container(
                              height: Dimensions.height30 * 4,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            itemsPerOrder[i], (index) {
                                          if (listCounter <
                                              getCartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Expanded(
                                                  child: Container(
                                                    height:
                                                        Dimensions.height20 * 4,
                                                    width:
                                                        Dimensions.width20 * 4,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstans
                                                                    .baseUrl +
                                                                AppConstans
                                                                    .uploadUrl +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20 * 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TitleText(
                                              text: "Total",
                                              color: AppColors.textBlack,
                                              size: Dimensions.font16 - 1,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            TitleText(
                                              text: "${itemsPerOrder[i]} Items",
                                              color: AppColors.textBlack,
                                              size: Dimensions.font16 - 1,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            GestureDetector(
                                              onTap: (() {
                                                var orderTime =
                                                    cartOrderTimeToList();
                                                Map<int, CartModel> moreOrder =
                                                    {};
                                                for (var j = 0;
                                                    j <
                                                        getCartHistoryList
                                                            .length;
                                                    j++) {
                                                  if (getCartHistoryList[j]
                                                          .time ==
                                                      orderTime[i]) {
                                                    moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                getCartHistoryList[
                                                                    j]))));
                                                  }
                                                }
                                                Get.find<CartController>()
                                                    .setItems = moreOrder;
                                                Get.find<CartController>()
                                                    .addToCartList();
                                                Get.toNamed(
                                                    RouteHelper.getCart());
                                              }),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10,
                                                    vertical:
                                                        Dimensions.height10 /
                                                            2),
                                                decoration: BoxDecoration(
                                                    color: AppColors.mainWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.25),
                                                        blurRadius: 1,
                                                      )
                                                    ]),
                                                child: TitleText(
                                                  text: "Review",
                                                  color: AppColors.textBlack,
                                                  size: Dimensions.font16 - 1,
                                                  fontWeight: FontWeight.w500,
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
                            )
                        ]),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                        child: NoDataPage(text: "Tidak Ada Riwayat")));
          })
        ],
      ),
    );
  }
}
