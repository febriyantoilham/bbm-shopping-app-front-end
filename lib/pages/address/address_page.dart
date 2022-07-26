import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          children: [
            /* Top Bar */
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
                  text: "Shipping Address",
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            /* Top Bar End */
            SizedBox(height: Dimensions.height20),
            /* Address List */
            GetBuilder<LocationController>(builder: (address) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: address.addressList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (() {
                          // Get.toNamed(RouteHelper.getProduct(index, "home"));
                        }),
                        child: Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          padding: EdgeInsets.all(Dimensions.height20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Address Icon
                              Column(
                                children: [
                                  TitleText(
                                    text:
                                        address.addressList[index].addressType,
                                    size: Dimensions.font16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  AppIcon(
                                    icon: address.addressList[index]
                                                .addressType ==
                                            "Home"
                                        ? Icons.home
                                        : address.addressList[index]
                                                    .addressType ==
                                                "Office"
                                            ? Icons.work
                                            : Icons.location_on,
                                    size: Dimensions.height45,
                                    iconSize: Dimensions.height20,
                                    bgColor: AppColors.mainIcon,
                                    icColor: AppColors.mainWhite,
                                  ),
                                ],
                              ),
                              SizedBox(width: Dimensions.width20),
                              //text product
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Dimensions.height5),
                                    TitleText(
                                      text:
                                          "${address.addressList[index].contactPersonName}",
                                      size: Dimensions.font14,
                                      color: AppColors.textColor,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                    TitleText(
                                      text:
                                          "${address.addressList[index].contactPersonNumber}",
                                      size: Dimensions.font14,
                                      color: AppColors.textColor,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                    Text(
                                      address.addressList[index].address,
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: Dimensions.font14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getAddAddress());
                    },
                    child: TitleText(
                      text: "Add New Address",
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w500,
                      size: Dimensions.font16,
                    ),
                  ),
                ],
              );
            }),
            /* AddressList */
          ],
        ),
      ),
    );
  }
}
