import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:onlineshop/data/api/api_client.dart';
import 'package:onlineshop/models/register_model.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(RegisterModel registerModel) async {
    return await apiClient.postData(
        AppConstans.regisUrl, registerModel.toJson());
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstans.token) ?? "None";
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstans.token);
  }

  Future<Response> login(String email, String password) async {
    return await apiClient
        .postData(AppConstans.loginUrl, {"email": email, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstans.token, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstans.phone, number);
      await sharedPreferences.setString(AppConstans.password, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearShareData() {
    sharedPreferences.remove(AppConstans.token);
    sharedPreferences.remove(AppConstans.password);
    sharedPreferences.remove(AppConstans.phone);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
