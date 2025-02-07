import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/base/custom_app_bar.dart';
import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/screens/order/view_order.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/widgets/big_text.dart';

import '../../controllers/order_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoggedIn = false; // Initialize to false to prevent errors

  @override
  void initState() {
    super.initState();

    // Check login status
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we don't use _tabController if the user is not logged in
    return _isLoggedIn
        ? Scaffold(
      appBar: CustomAppBar(title: "My Orders"),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.mainColor,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.yellowColor,
              tabs: [
                Tab(text: "Current"),
                Tab(text: "History"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          )
        ],
      ),
    )
        :  Container(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height30*10,
              margin: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:AssetImage("assets/image/NotLoggedIn.jpg") )
              ),
            ),
            SizedBox(height: Dimensions.height20),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());
              },
              child:Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Center(child:BigText(text: "Sign in", color: Colors.white, size: Dimensions.font26,),)
              ),
            )
          ],
        )

    )); // Show empty screen if not logged in
  }

  @override
  void dispose() {
    if (_isLoggedIn) {
      _tabController.dispose(); // Dispose controller only if initialized
    }
    super.dispose();
  }
}

