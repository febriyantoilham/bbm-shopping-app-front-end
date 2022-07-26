import 'package:get/get.dart';
import 'package:onlineshop/data/repo/all_product_repo.dart';
import 'package:onlineshop/models/products_model.dart';

class AllProductController extends GetxController {
  final AllProductRepo allProductRepo;
  AllProductController({required this.allProductRepo});
  List<dynamic> _allproductList = [];
  List<dynamic> get allproductList => _allproductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllProductList() async {
    Response response = await allProductRepo.getAllProductList();
    if (response.statusCode == 200) {
      // print("got recommend products");
      _allproductList = [];
      _allproductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
      // print("Get All Product List Controller = ${response.statusCode}");
    } else {}
  }
}
