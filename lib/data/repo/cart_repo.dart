// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:onlineshop/models/cart_model.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = []; /* this object contain item on cart page */
  List<String> cartHistory = []; /* this object contain item on history page */

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstans.cartList);
    // sharedPreferences.remove(AppConstans.cartListHistory);
    var time = DateTime.now().toString();
    cart = []; /* Global Cart Object*/
    /*
      convert object to string because sharedPreferences only accept string
    */

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstans.cartList, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstans.cartList)) {
      carts = sharedPreferences.getStringList(AppConstans.cartList)!;
    }

    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstans.cartListHistory)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstans.cartListHistory)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstans.cartListHistory)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstans.cartListHistory)!;
    }

    for (var i = 0; i < cart.length; i++) {
      // adding data from cart page
      cartHistory.add(cart[i]);
    }

    cart = [];
    sharedPreferences.setStringList(AppConstans.cartListHistory, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstans.cartList);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstans.cartListHistory);
  }

  void removeCartSharedPreferences() {
    sharedPreferences.remove(AppConstans.cartList);
    sharedPreferences.remove(AppConstans.cartListHistory);
  }
}
