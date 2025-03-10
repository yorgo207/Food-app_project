import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/controllers/cart_controller.dart';
import 'package:toters/controllers/user_controller.dart';
import 'package:toters/data/api/api_client.dart';
import 'package:toters/data/repository/auth_repo.dart';
import 'package:toters/data/repository/cart_repo.dart';
import 'package:toters/data/repository/popular_product_repo.dart';
import 'package:toters/data/repository/recommended_product_repo.dart';
import 'package:toters/data/repository/user_repo.dart';
import 'package:toters/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/order_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/order_repo.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repos
  Get.lazyPut(()=> PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=>UserRepo(apiClient: Get.find()));
  Get.lazyPut(()=>OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(()=>PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(()=>CartController(cartRepo: Get.find()));
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(()=>UserController(userRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

}