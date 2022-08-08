import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/location_controller_old.dart';
import 'package:onlineshop/controller/order_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/pages/orders/history_page.dart';
import 'package:onlineshop/pages/orders/view_orders.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

enum Type { ongoing, history }

class _OrdersPageState extends State<OrdersPage> {
  Future<void> _loadResource() async {
    await Get.find<UserController>().getUserInfo();
    await Get.find<OrderController>().getOrderList();
    await Get.find<OrderController>().getOrderDetails();
  }

  String type = "ongoing";
  late bool _isLoggedIn;
  onTapType(Type typeInput) {
    if (typeInput == Type.ongoing) {
      type = "ongoing";
    } else {
      type = "history";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<OrderController>().getOrderList();
      Get.find<OrderController>().getOrderDetails();
    }
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: RefreshIndicator(
        onRefresh: _loadResource,
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
          padding: EdgeInsets.all(Dimensions.height20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: "My Orders",
                size: Dimensions.font26,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: type == "ongoing"
                            ? AppColors.mainColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              BorderSide(width: 1, color: AppColors.mainColor),
                        ),
                      ),
                      onPressed: () {
                        onTapType(Type.ongoing);
                      },
                      child: Text(
                        "Ongoing",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: type == "ongoing"
                              ? Colors.white
                              : AppColors.mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: type == "history"
                            ? AppColors.mainColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              BorderSide(width: 1, color: AppColors.mainColor),
                        ),
                      ),
                      onPressed: () {
                        onTapType(Type.history);
                      },
                      child: Text(
                        "History",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: type == "history"
                              ? Colors.white
                              : AppColors.mainColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height15),
              Expanded(
                child: type == "ongoing" ? ViewOrders() : HistoryPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
