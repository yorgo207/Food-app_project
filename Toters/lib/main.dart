import 'package:flutter/material.dart';
import 'package:toters/auth/sign_in_page.dart';
import 'package:toters/auth/sign_up_page.dart';
import 'package:toters/controllers/cart_controller.dart';
import 'package:toters/controllers/popular_product_controller.dart';
import 'package:toters/controllers/user_controller.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:toters/helper/dependencies.dart' as dep;

import 'controllers/recommended_product_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetBuilder<UserController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            //home: SignInPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        }
        );

      });
    });
  }
}


