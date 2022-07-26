import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.height20,
            right: Dimensions.height20,
            top: Dimensions.statusBarWidth),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: "Select Your Address",
                    color: AppColors.mainIcon,
                    size: Dimensions.font18,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: Dimensions.height20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: address.addressList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              address.setAddressSelectedIndex(index);
                            }),
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height15),
                              padding: EdgeInsets.all(Dimensions.height10),
                              decoration: BoxDecoration(
                                  color: AppColors.mainWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color:
                                          address.addressSelectedIndex == index
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
                                      children: [
                                        // Address Icon
                                        SizedBox(height: Dimensions.height5),
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
                                          size: Dimensions.height50,
                                          iconSize: Dimensions.height30,
                                          bgColor: AppColors.mainIcon,
                                          icColor: AppColors.mainWhite,
                                        ),
                                        SizedBox(width: Dimensions.width15),
                                        //text product
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TitleText(
                                                text: address.addressList[index]
                                                    .addressType,
                                                size: Dimensions.font14,
                                                color: AppColors.textColor,
                                              ),
                                              SizedBox(
                                                  height: Dimensions.height5),
                                              TitleText(
                                                text:
                                                    "${address.addressList[index].contactPersonName}",
                                                size: Dimensions.font14,
                                                color: AppColors.textColor,
                                              ),
                                              SizedBox(
                                                  height: Dimensions.height5),
                                              TitleText(
                                                text:
                                                    "${address.addressList[index].contactPersonNumber}",
                                                size: Dimensions.font14,
                                                color: AppColors.textColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width15),
                                        // Radio Button
                                        Icon(
                                          address.addressSelectedIndex == index
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          color: AppColors.mainIcon,
                                        )
                                      ],
                                    ),
                                    address.addressSelectedIndex == index
                                        ? Column(
                                            children: [
                                              Divider(
                                                height: Dimensions.height20,
                                                thickness: 1,
                                              ),
                                              Container(
                                                child: Text(
                                                  address.addressList[index]
                                                      .address,
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font14,
                                                    color: AppColors.textColor,
                                                    height: 1.3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
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
                          text: "Create New Address",
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500,
                          size: Dimensions.font16,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            /* AddressList */
          ],
        ),
      ),
      bottomNavigationBar:
          /* Bottom Bar */
          Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20, vertical: Dimensions.height30),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: double.maxFinite,
            height: Dimensions.height50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20 + 5),
              color: AppColors.mainColor,
            ),
            child: Center(
              child: TitleText(
                text: "Apply",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      /* Bottom Bar End*/
    );
  }
}
