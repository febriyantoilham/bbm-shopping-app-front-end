import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/models/address_model.dart';
import 'package:onlineshop/pages/address/maps.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoggedIn;
  CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(-6.1822452073508884, 106.82888746261597), zoom: 17);
  late LatLng _initialPosition =
      LatLng(-6.1822452073508884, 106.82888746261597);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    // Checking user information in user model is not empty
    if (_isLoggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
    }
    // Checking user already have address or not
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocal() == "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SingleChildScrollView(
          child: Container(
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
                      text: "Add Address",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                /* Top Bar End */
                SizedBox(height: Dimensions.height10),
                GetBuilder<UserController>(builder: (userController) {
                  if (userController.userModel != null &&
                      _contactPersonName.text.isEmpty) {
                    _contactPersonName.text =
                        '${userController.userModel?.name}';
                    _contactPersonNumber.text =
                        '${userController.userModel?.phone}';
                    if (Get.find<LocationController>().addressList.isNotEmpty) {
                      _addressController.text = Get.find<LocationController>()
                          .getUserAddress()
                          .address;
                    }
                  }
                  return GetBuilder<LocationController>(
                    builder: (locationController) {
                      _addressController.text =
                          '${locationController.placemark.name ?? ''}'
                          '${locationController.placemark.locality ?? ''}'
                          '${locationController.placemark.postalCode ?? ''}'
                          '${locationController.placemark.country ?? ''}';
                      // print("address" + _addressController.text);
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 140,
                              width: Dimensions.screenWidth,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                )
                              ]),
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: _initialPosition, zoom: 17),
                                    onTap: (latlng) {
                                      Get.toNamed(RouteHelper.getMaps(),
                                          arguments: MapsPage(
                                              fromSignUp: false,
                                              fromAddress: true,
                                              googleMapController:
                                                  locationController
                                                      .mapController));
                                    },
                                    zoomControlsEnabled: false,
                                    compassEnabled: false,
                                    indoorViewEnabled: true,
                                    mapToolbarEnabled: false,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    onCameraIdle: () {
                                      locationController.updatePosition(
                                          _cameraPosition, true);
                                    },
                                    onCameraMove: ((position) =>
                                        _cameraPosition = position),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      locationController
                                          .setMapController(controller);
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.height20),
                            TitleText(
                              text: "Address Type",
                              size: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: Dimensions.height10),
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      locationController.addressTypeList.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: (() {
                                        locationController
                                            .setAddressTypeIndex(index);
                                      }),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: Dimensions.width5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.height10,
                                            horizontal: Dimensions.height20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20 / 4),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                              ),
                                            ]),
                                        child: Row(children: [
                                          Icon(
                                            index == 0
                                                ? Icons.home_filled
                                                : index == 1
                                                    ? Icons.work
                                                    : Icons.location_on,
                                            color: locationController
                                                        .addressTypeIndex ==
                                                    index
                                                ? AppColors.mainColor
                                                : Theme.of(context)
                                                    .disabledColor,
                                          )
                                        ]),
                                      ),
                                    );
                                  })),
                            ),
                            SizedBox(height: Dimensions.height20),
                            TitleText(
                              text: "Delivery Address",
                              size: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: Dimensions.height5),
                            AppTextFieldPage(
                              textController: _addressController,
                              hintText: "Your Address",
                              icon: Icons.map,
                              readOnly: true,
                            ),
                            SizedBox(height: Dimensions.height20),
                            TitleText(
                              text: "Contact Person",
                              size: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: Dimensions.height5),
                            AppTextFieldPage(
                              textController: _contactPersonName,
                              hintText: "Your Name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: Dimensions.height20),
                            TitleText(
                              text: "Phone Number",
                              size: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: Dimensions.height5),
                            AppTextFieldPage(
                              textController: _contactPersonNumber,
                              hintText: "Your Number",
                              icon: Icons.phone,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: ((controller) {
          return Container(
            height: Dimensions.screenHeight / (Dimensions.screenHeight / 100),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width45,
              vertical: Dimensions.height30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                  )
                ],
                color: AppColors.secondaryColor),
            // Bottom Bar
            child: GestureDetector(
              onTap: () {
                AddressModel _addressModel = AddressModel(
                  addressType:
                      controller.addressTypeList[controller.addressTypeIndex],
                  contactPersonName: _contactPersonName.text,
                  contactPersonNumber: _contactPersonNumber.text,
                  address: _addressController.text,
                  latitude: controller.position.latitude.toString(),
                  longitude: controller.position.longitude.toString(),
                );
                controller.addAddress(_addressModel).then(
                  (response) {
                    if (response.isSuccess) {
                      Get.back();
                      customSnackBar("Successfully added",
                          title: "Add Address", color: Colors.green);
                    } else {
                      customSnackBar("Failed to add address",
                          title: "Add Address");
                    }
                  },
                );
              },
              child: Container(
                width: Dimensions.screenWidth / (Dimensions.screenWidth / 270),
                height:
                    Dimensions.screenHeight / (Dimensions.screenHeight / 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: TitleText(
                    text: "Save",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        })),
      ),
    );
  }
}
