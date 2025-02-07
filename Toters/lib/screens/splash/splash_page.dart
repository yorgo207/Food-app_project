import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}): super(key:key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  Future<void>_loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  
  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
    animation= CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
      ()=>Get.offNamed(RouteHelper.getInitial(pageId:3))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
           child:  Center(child: Image.asset("assets/image/TotersLogo.jpg", width: Dimensions.width30*15,)),
          ),
          Center(child: Image.asset("assets/image/TotersLogo2.webp", width: Dimensions.width30*30,)),
        ],
      ),
    );
  }
}