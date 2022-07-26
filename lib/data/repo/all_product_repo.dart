import 'package:get/get.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/utils/app_constants.dart';

class AllProductRepo extends GetxService {
  final ApiClient apiClient;
  AllProductRepo({required this.apiClient});

  Future<Response> getAllProductList() async {
    return await apiClient.getData(AppConstans.allUrl);
  }
}
