import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlineshop/base/custom_button.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/pages/address/widgets/search_location.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/title_text.dart';

class MapsPage extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const MapsPage(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(-6.1822452073508884, 106.82888746261597);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                    if (!widget.fromAddress) {}
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/images/pin.png",
                          height: Dimensions.screenHeight /
                              (Dimensions.screenHeight / 50),
                          width: Dimensions.screenWidth /
                              (Dimensions.screenWidth / 50),
                        )
                      : CircularProgressIndicator(),
                ),
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Row(
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
                      SizedBox(width: Dimensions.width15),
                      Expanded(
                        child: InkWell(
                          // onTap: (() => Get.dialog(LocationSearchDialogue(
                          //     mapController: _mapController))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.mainWhite,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 10)
                                ]),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: Dimensions.height30,
                                  color: AppColors.mainColor,
                                ),
                                SizedBox(width: Dimensions.width5),
                                Expanded(
                                    child: TitleText(
                                  text:
                                      '${locationController.pickPlacemark.name ?? ''}',
                                  size: Dimensions.font16,
                                )),
                                SizedBox(width: Dimensions.width10),
                                Icon(
                                  Icons.search_outlined,
                                  size: Dimensions.height30,
                                  color: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 50,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: CustomButton(
                      buttonText: "Pick Address",
                      onPressed: locationController.loading
                          ? () {
                              print("null");
                            }
                          : () {
                              if (locationController.pickPosition.latitude !=
                                      0 &&
                                  locationController.pickPlacemark.name !=
                                      null) {
                                if (widget.fromAddress) {
                                  if (widget.googleMapController != null) {
                                    widget.googleMapController!.moveCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    locationController
                                                        .pickPosition.latitude,
                                                    locationController
                                                        .pickPosition
                                                        .longitude))));
                                    locationController.setAddAddressData();
                                  }
                                  // Get.offNamed(RouteHelper.getAddAddress());
                                  Get.back();
                                }
                              }
                            },
                    ))
              ],
            ),
          ),
        )),
      );
    });
  }
}
