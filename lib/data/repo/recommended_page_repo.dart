import 'package:get/get.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/utils/app_constants.dart';

class RecommendedPageRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedPageRepo({required this.apiClient});

  Future<Response> getRecommendedList() async {
    return await apiClient.getData(AppConstans.recommendedUrl);
  }
}
