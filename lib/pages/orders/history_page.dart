import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/no_data_page.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/order_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/models/order_model.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/title_text.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<OrderController>().getOrderList();
    }
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isloading == false) {
          late List<OrderModel> orderList;
          if (orderController.historyOrderList.isEmpty) {
            orderList = [];
          } else {
            orderList = orderController.historyOrderList.reversed.toList();
          }
          return orderList.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  width: Dimensions.screenWidth,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            orderController.setSelectedOrder(orderList[index]);
                            Get.toNamed(RouteHelper.getViewOrderDetails());
                          },
                          child: Container(
                            height: Dimensions.height50,
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height10),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  TitleText(
                                    text: "order_id: #" +
                                        orderList[index].id.toString(),
                                    color: Colors.black,
                                    size: Dimensions.font16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ]),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: Dimensions.width30,
                                    width: Dimensions.height100,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text(
                                      orderList[index].orderStatus.toString(),
                                      style:
                                          TextStyle(color: AppColors.mainWhite),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : const NoDataPage(text: "You don't have an order yet");
        } else {
          return Text("loading");
        }
      }),
    );
  }
}
