import 'package:get/get.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/models/place_order_model.dart';
import 'package:onlineshop/utils/app_constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(
        AppConstans.placeOrderUri, placeOrder.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstans.orderListUri);
  }

  Future<Response> getOrderDetails() async {
    return await apiClient.getData(AppConstans.orderDetailsUri);
  }
}
