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
import '../../utils/dimensions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {

  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController= TabController(length: 2, vsync: this);
      print("hello from here");
      Get.find<OrderController>().getOrderList();

    }else{

    }
  }


  @override
  Widget build(BuildContext context) {

  return Scaffold(
    appBar: CustomAppBar(title: "My Orders"),
    body: Column(
      children: [
        Container(
          width: Dimensions.screenWidth,
          child: TabBar(controller: _tabController,
              indicatorColor: AppColors.mainColor,
              indicatorWeight:3,
              indicatorSize:TabBarIndicatorSize.tab,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.yellowColor,
              tabs: [
                Tab(text: "Current"),
                Tab(text: "History"),
              ]
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ViewOrder(isCurrent: true),
              ViewOrder(isCurrent: false),
            ]),
        )
      ],
    )

  );
}
}
