import 'package:flutter/material.dart';
import 'package:onlineshop/pages/cart/cart_history_page.dart';
import 'package:onlineshop/pages/cart/cart_page.dart';
import 'package:onlineshop/pages/home/main_page.dart';
import 'package:onlineshop/pages/orders/orders.dart';
import 'package:onlineshop/pages/catalogue/catalogue.dart';
import 'package:onlineshop/pages/profile/profile_page.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:onlineshop/widgets/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    CataloguePage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColors.backgroundButton,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: AppColors.iconYellow,
              tabs: const [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.library_books_outlined,
                  text: 'Catalogue',
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Orders',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
