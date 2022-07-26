import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/data/repo/recommended_page_repo.dart';
import 'package:onlineshop/models/cart_model.dart';
import 'package:onlineshop/models/products_model.dart';

class RecommendedPageController extends GetxController {
  final RecommendedPageRepo recommendedPageRepo;
  RecommendedPageController({required this.recommendedPageRepo});
  List<dynamic> _recommendedList = [];
  List<dynamic> get recommendedList => _recommendedList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Quantity Produk
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedList() async {
    Response response = await recommendedPageRepo.getRecommendedList();
    if (response.statusCode == 200) {
      _recommendedList = [];
      _recommendedList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  // Set Kuantitas Produk
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Error : Item Count", "You can't reduce more",
          backgroundColor: Colors.white, colorText: Colors.black);
      if (inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 99999) {
      return 99999;
    } else {
      return quantity;
    }
  }

  void initRecommended(ProductModel recommended, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(recommended);

    // Get from storage
    // print("Exist or not" + exist.toString());
    if (exist) {
      _inCartItems = cart.getQuantity(recommended);
    }
    // print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel recommended) {
    _cart.addItem(recommended, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(recommended);
    // _cart.items.forEach((key, value) {
    //   Get.snackbar("The id is" + value.id.toString(),
    //       "The Quantity is" + value.quantity.toString(),
    //       backgroundColor: Colors.white, colorText: Colors.black);
    // });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
