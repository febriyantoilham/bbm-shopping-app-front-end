import 'package:get/get.dart';
import 'package:onlineshop/models/order_model.dart';
import 'package:onlineshop/pages/address/add_address.dart';
import 'package:onlineshop/pages/address/address_page.dart';
import 'package:onlineshop/pages/address/maps.dart';
import 'package:onlineshop/pages/auth/login_page.dart';
import 'package:onlineshop/pages/auth/register_page.dart';
import 'package:onlineshop/pages/cart/cart_history_page.dart';
import 'package:onlineshop/pages/cart/cart_page.dart';
import 'package:onlineshop/pages/checkout/checkout_page.dart';
import 'package:onlineshop/pages/checkout/choose_address.dart';
import 'package:onlineshop/pages/cs/support_page.dart';
import 'package:onlineshop/pages/home/home_page.dart';
import 'package:onlineshop/pages/orders/view_order_details.dart';
import 'package:onlineshop/pages/payment/order_success_manual_page.dart';
import 'package:onlineshop/pages/payment/order_success_page.dart';
import 'package:onlineshop/pages/payment/payment_option_page.dart';
import 'package:onlineshop/pages/payment/payment_page.dart';
import 'package:onlineshop/pages/product/all_product_item_page.dart';
import 'package:onlineshop/pages/product/recommended_page.dart';
import 'package:onlineshop/pages/product/product_item_page.dart';
import 'package:onlineshop/pages/profile/profile_details.dart';
import 'package:onlineshop/pages/profile/profile_page.dart';
import 'package:onlineshop/pages/splash/splash_screen.dart';
import 'package:onlineshop/pages/splash/started_page.dart';

class RouteHelper {
  static const String splash = "/splash";
  static const String started = "/started";
  static const String initial = "/";
  static const String recommended = "/recommended";
  static const String product = "/product";
  static const String allProduct = "/all-product";
  static const String cart = "/cart";
  static const String cartHistory = "/cart-history";
  static const String login = "/login";
  static const String signUp = "/SignUp";
  static const String profile = "/profile";
  static const String profileDetails = "/profileDetails";
  static const String addAddress = "/addAddress";
  static const String address = "/address";
  static const String maps = "/maps";
  static const String checkout = "/checkout";
  static const String chooseAddress = "/chooseAddress";
  static const String paymentOption = "/payment-option";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";
  static const String orderSuccessManual = "/order-successful-manual";
  static const String viewOrderDetails = "/view-order-detail";
  static const String supportPage = "/support-page";

  static String getSplash() => splash;
  static String getStarted() => started;
  static String getInitial() => initial;
  static String getrecommended(int pageId, String page) =>
      '$recommended?pageId=$pageId&page=$page';
  static String getProduct(int pageId, String page) =>
      '$product?pageId=$pageId&page=$page';
  static String getAllProduct(int pageId, String page) =>
      '$allProduct?pageId=$pageId&page=$page';
  static String getCart() => cart;
  static String getCartHistory() => cartHistory;
  static String getLogin() => login;
  static String getSignUp() => signUp;
  static String getProfile() => profile;
  static String getProfileDetails() => profileDetails;
  static String getAddAddress() => addAddress;
  static String getAddress() => address;
  static String getMaps() => maps;
  static String getCheckout() => checkout;
  static String getChooseAddress() => chooseAddress;
  static String getPaymentOption() => paymentOption;
  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccess(String orderID, String status) =>
      '$orderSuccess?id=$orderID&status=$status';
  static String getOrderSuccessManual() => orderSuccessManual;
  static String getViewOrderDetails() => viewOrderDetails;
  static String getSupportPage() => supportPage;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: started, page: () => const StartedPage()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: signUp, page: () => const RegisterPage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: profileDetails, page: () => const ProfileDetailsPage()),
    GetPage(name: paymentOption, page: () => const PaymentOptionPage()),
    GetPage(name: viewOrderDetails, page: () => const ViewOrderDetails()),
    GetPage(name: supportPage, page: () => const SupportPage()),
    GetPage(
        name: maps,
        page: () {
          MapsPage _mapsPage = Get.arguments;
          return _mapsPage;
        }),
    GetPage(
        name: recommended,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedPage(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
      name: product,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return ProductItemPage(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: allProduct,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        // Need to change
        return AllProductItemPage(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cart,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartHistory,
      page: () {
        return const CartHistoryPage();
      },
    ),
    GetPage(name: addAddress, page: () => const AddAddressPage()),
    GetPage(name: address, page: () => const AddressPage()),
    GetPage(name: checkout, page: () => const CheckoutPage()),
    GetPage(name: chooseAddress, page: () => const ChooseAddress()),
    GetPage(
        name: payment,
        page: () => PaymentScreen(
              orderModel: OrderModel(
                  id: int.parse(Get.parameters['id']!),
                  userId: int.parse(Get.parameters['userID']!)),
            )),
    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
              orderID: Get.parameters["id"]!,
              status: Get.parameters["status"].toString().contains("success")
                  ? 1
                  : 0,
            )),
    GetPage(name: orderSuccessManual, page: () => OrderSuccessPageManual()),
  ];
}
