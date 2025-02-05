import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/base/show_custom_snackbar.dart';
import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/controllers/cart_controller.dart';
import 'package:toters/controllers/order_controller.dart';
import 'package:toters/controllers/popular_product_controller.dart';
import 'package:toters/models/place_order_model.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/utils/app_constants.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/app_icon.dart';
import 'package:toters/widgets/big_text.dart';
import 'package:toters/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';

class CartPage extends StatelessWidget {
  int pageId;
  final String page;
  CartPage({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height30*2,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=="recommendedFood"){Get.toNamed(RouteHelper.getRecommendedFood(pageId, "cartpage"));}
                    else if(page=="popularFood"){Get.toNamed(RouteHelper.getPoplarFood(pageId, "cartpage"));}
                    else {Get.toNamed(RouteHelper.getInitial());}
                  },
                  child: AppIcon(icon: Icons.arrow_back, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,),
                ),
                SizedBox(width: Dimensions.width30*10,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.home_outlined, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,),
                ),
                AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,),

              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder <CartController>(builder: (cartController){
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                              itemCount: _cartList.length ,
                              itemBuilder: (_, index){
                                return Container(
                                    height:120,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            var popularIndex = Get.find<PopularProductController>()
                                                .popularProductList.indexOf(_cartList[index].product);
                                            if (popularIndex>=0){
                                              Get.toNamed(RouteHelper.getPoplarFood(popularIndex, "cartpage"));
                                            }else{
                                              var recommendedIndex = Get.find<RecommendedProductController>()
                                                  .recommendedProductList.indexOf(_cartList[index].product);
                                              if(recommendedIndex<0){
                                                Get.snackbar("History Product", "Unable to view Products from history",
                                                  backgroundColor: AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              }else{
                                                Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, 'cartpage'));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20*5,
                                            height: Dimensions. height20*5,
                                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!,
                                                    )),
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10,),
                                        Expanded(
                                            child: Container(
                                                height: Dimensions.radius20*5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    BigText(text: cartController.getItems[index].name!, color: Colors.black54),
                                                    Row(
                                                      children: [
                                                        SmallText(text: "spicy", color: Colors.black54),
                                                        SizedBox(width: Dimensions.width30*10,),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.addItem(_cartList[index].product!, -1);
                                                              },
                                                              child: Icon(Icons.remove, color:AppColors.signColor),
                                                            ),
                                                            SizedBox(width: Dimensions.width10),
                                                            BigText(text: _cartList[index].quantity.toString()),
                                                            SizedBox(width: Dimensions.width10),
                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.addItem(_cartList[index].product!, 1);
                                                              },
                                                              child: Icon(Icons.add, color:AppColors.signColor),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        BigText(text: cartController.getItems[index]!.price.toString(), color: Colors.redAccent),
                                                        Container(
                                                          height: Dimensions.height30,
                                                          padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height20 ,left:Dimensions.width10, right: Dimensions.width10),

                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            )
                                        ),
                                      ],
                                    )
                                );
                              });}
                        ))
                )):NoDataPage(text:"Cart is Empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: cartController.getItems.length>0? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Dimensions.height30*2,
                  padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left:Dimensions.width30, right: Dimensions.width30),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [

                      SizedBox(width: Dimensions.width20),
                      BigText(text: "\$"+cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width20),

                    ],
                  ),
                ),
                GestureDetector(
                    onTap: (){
                      if(Get.find<AuthController>().userLoggedIn()) {
                        cartController.addToHistory();
                        var location="Beirut";
                        var cart=Get.find<CartController>().getItems;
                        print("cart"+cart.toString());
                        var user=Get.find<UserController>().userModel;
                        PlaceOrderBody placeOrder =PlaceOrderBody(
                          cart: cart,
                          orderAmount: 100.0,
                          orderNote: "Note about food",
                          address: location,
                          latitude: "33.8869",
                          longitude: "35.5192",
                          contactPersonName:user.name,
                          contactPersonNumber: user.name,
                          scheduleAt: '', distance: 10.0,
                        );
                        cartController.clear();
                        Get.find<OrderController>().placeOrder(placeOrder);

                      }else{
                        Get.toNamed(RouteHelper.getSignInPage());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left:Dimensions.width30, right: Dimensions.width30),
                      child: BigText(text: "Check Out", color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                    )
                ),
              ],
            ):Container(),
        );
      }, ),
    );
  }
}

/*void _callback(bool isSuccess, String message, String orderID){
  if(isSuccess){
    Get.offNamed(RouteHelper.getPaymentPage(orderID , Get.find<UserController>().userModel!.id!));
  }else{
    showCustomSnackBar(message);
  }
}*/