import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/auth/sign_in_page.dart';
import 'package:toters/auth/sign_up_page.dart';
import 'package:toters/screens/cart/cart_history.dart';
import 'package:toters/screens/home/main_food_page.dart';
import 'package:toters/screens/account/account_page.dart';
import 'package:toters/screens/order/order_page.dart';

import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  int pageId;
  HomePage({Key? key, required this.pageId}): super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  void initState() {
    super.initState();
    _selectedIndex = widget.pageId; // Access pageId through widget
  }


  List pages = [
    MainFoodPage(),
    OrderPage(),
    CartHistory(),
    AccountPage(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "history",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "me",
          ),
        ],
      ),
    );
  }

}
