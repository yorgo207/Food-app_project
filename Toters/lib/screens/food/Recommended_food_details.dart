import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/controllers/popular_product_controller.dart';
import 'package:toters/controllers/recommended_product_controller.dart';
import 'package:toters/widgets/app_icon.dart';
import 'package:toters/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  final String page;
  RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId]!;
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      //scrollable text description
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=="cartpage"){Get.toNamed(RouteHelper.getCartPage(pageId, "recommendedFood"));}
                    else {Get.toNamed(RouteHelper.getInitial());}
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(controller.totalItems>0){Get.toNamed(RouteHelper.getCartPage(pageId, "recommendedFood"));}
                        },
                        child:AppIcon(icon: Icons.shopping_cart_outlined),
                      ),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right:0, top:0,
                          child: AppIcon(icon: Icons.circle, size: Dimensions.iconSize16, iconColor: Colors.transparent,backgroundColor: AppColors.mainColor)
                      )
                          :Container(),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right:3.5, top:-2,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                              color: Colors.white, size: Dimensions.font14)
                      )
                          :Container(),
                    ],

                  );
                },)
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(text:product.name, size: Dimensions.font26,)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top:5, bottom:Dimensions.height10),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.height30*12,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network( AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ product.img!,
                width:double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(left:Dimensions.width20, right: Dimensions.width20),
                )
              ],
            )
          ),
        ],
      ),

      //bottom navbar
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left:Dimensions.width30*5,
                right:Dimensions.width30*5,
                top: Dimensions.height10,
                bottom:Dimensions.height10,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child:AppIcon(icon: Icons.remove, backgroundColor: AppColors.mainColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24,),
                  ),
                  BigText(text: "\$ ${product.price!} "+"X"+"${controller.inCartItems}", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child:AppIcon(icon: Icons.add, backgroundColor: AppColors.mainColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24,),
                  ),
                ],
              ),
            ),
            Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20*2),
                      topRight: Radius.circular(Dimensions.radius20*2),
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: Dimensions.height30*2,
                        padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left:Dimensions.width30, right: Dimensions.width30),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite, color: AppColors.mainColor,size: Dimensions.iconSize24*1.5,
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.addItem(product);
                      },
                      child:   Container(
                        padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left:Dimensions.width30, right: Dimensions.width30),
                        child: BigText(text: "\$ ${product.price!} " +"| Add to cart", color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        );
      }),
    );
  }
}
