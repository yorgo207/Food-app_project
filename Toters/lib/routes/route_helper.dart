import 'package:toters/auth/sign_in_page.dart';
import 'package:toters/models/order_model.dart';
import 'package:toters/screens/cart/cart_page.dart';
import 'package:toters/screens/food/Recommended_food_details.dart';
import 'package:toters/screens/food/popular_food_detail.dart';
import 'package:toters/screens/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:toters/screens/payment/payment_page.dart';

import '../screens/home/home_page.dart';
import '../screens/order/order_detail.dart';
import '../screens/splash/splash_page.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage = "/cart-helper";
  static const String signIn="/sign-in";
  static const String payment="/payment";
  static const String orderSuccess="/order-successful";
  static const String orderDetail="/order-detail";



  static String getSplashPage()=>'$splashPage';
  static String getInitial({int pageId=0})=>'$initial?pageId=$pageId';
  static String getPoplarFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage(int pageId, String page)=>'$cartPage?pageId=$pageId&page=$page';
  static String getSignInPage()=>'$signIn';
  static String getPaymentPage(String id, int userID)=>'$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status )=>'$orderSuccess?id=$orderID&status=$status';
  static String getOrderDetail(String orderId)=>'$orderDetail?order=$orderId';


  static List<GetPage> routes = [

    GetPage(name:splashPage, page:()=>SplashScreen()),

    GetPage(name: initial, page:(){
      var id=Get.parameters['pageId'];
      return HomePage(pageId: int.parse(id!));}),

    GetPage(name: popularFood, page:(){
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: recommendedFood, page:(){
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!), page:page!);

    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page:(){
      var pageId=Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return CartPage(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: signIn, page:(){
      return SignInPage();}, transition:Transition.fade),

    GetPage(name: payment, page: ()=>PaymentPage(
        orderModel: OrderModel(id:int.parse(Get.parameters['id']!),
            userId: int.parse(Get.parameters['userID']!))),
    ),

    //GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      //orderID: Get.parameters['id'], status:Get.parameters['status'].toString().contains("success")?1:0,
    //))
    GetPage(name: orderDetail, page:(){
      var order = Get.parameters['order'];
      return OrderDetail(orderId: order!);},
        transition:Transition.fade),

  ];
}