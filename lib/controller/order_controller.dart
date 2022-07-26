import 'package:get/get.dart';
import 'package:onlineshop/data/repo/order_repo.dart';
import 'package:onlineshop/models/address_model.dart';
import 'package:onlineshop/models/order_detail_model.dart';
import 'package:onlineshop/models/order_model.dart';
import 'package:onlineshop/models/place_order_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  List<OrderModel> _currentOrderList = [];
  List<OrderModel> _historyOrderList = [];

  List<OrderDetailModel> _currentOrderDetail = [];
  List<OrderDetailModel> _historyOrderDetail = [];

  bool get isloading => _isLoading;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  List<OrderDetailModel> get currentOrderDetail => _currentOrderDetail;
  List<OrderDetailModel> get historyOrderDetail => _historyOrderDetail;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callBack) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);

    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callBack(true, message, orderID);
    } else {
      callBack(false, response.statusText!, "-1");
      print("the response is ${response.statusCode}");
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _currentOrderList = [];
      _historyOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'finished' ||
            orderModel.orderStatus == 'Finished') {
          _historyOrderList.add(orderModel);
        } else {
          _currentOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    update();
  }

  Future<void> getOrderDetails() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderDetails();
    if (response.statusCode == 200) {
      _currentOrderDetail = [];
      _historyOrderDetail = [];
      response.body.forEach((order) {
        _currentOrderDetail.add(OrderDetailModel.fromJson(order));
        _historyOrderDetail.add(OrderDetailModel.fromJson(order));
      });
    } else {
      _currentOrderDetail = [];
      _historyOrderDetail = [];
    }
    _isLoading = false;
    update();
  }

  final List<String> _paymentList = ["Bank Transfer", "Paypal"];
  List<String> get paymentList => _paymentList;

  int _paymentSelectedIndex = 0;
  int get paymentSelectedIndex => _paymentSelectedIndex;
  void setPaymentSelectedIndex(int index) {
    _paymentSelectedIndex = index;
    update();
  }

  late OrderModel _selectedOrder;
  OrderModel get selectedOrder => _selectedOrder;

  void setSelectedOrder(OrderModel orderList) {
    _selectedOrder = orderList;
    update();
  }
}
