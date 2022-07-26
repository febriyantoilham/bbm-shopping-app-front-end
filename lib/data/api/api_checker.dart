import 'package:get/get.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/route/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offAndToNamed(RouteHelper.getLogin());
    } else {
      customSnackBar(response.statusText!);
    }
  }
}
