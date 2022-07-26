import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/models/address_model.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeoCode(LatLng latlng) async {
    return await apiClient.getData('${AppConstans.geoCodeUri}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstans.userAddress) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstans.addUserAddress, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstans.addressList);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstans.token)!);
    return await sharedPreferences.setString(
        AppConstans.userAddress, userAddress);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstans.zoneUri}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient
        .getData('${AppConstans.searchLocationUrl}?search_tex=$text');
  }

  Future<Response> setLocation(String, placeId) async {
    return await apiClient
        .getData('${AppConstans.placeDetailsUri}?placeid=$placeId');
  }
}
