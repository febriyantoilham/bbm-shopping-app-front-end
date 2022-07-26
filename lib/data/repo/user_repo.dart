import 'package:get/get.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstans.userUrl);
  }
}
