import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/controllers/popular_product_controller.dart';
import 'package:toters/controllers/recommended_product_controller.dart';
import 'package:toters/models/products_model.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/screens/food/popular_food_detail.dart';
import 'package:toters/utils/app_constants.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/big_text.dart';
import 'package:toters/widgets/icon_and_text_widget.dart';
import 'package:toters/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currPageValue= 0.0;
  double _scaleFactor = 0.9;
  double _height = Dimensions.pageViewContainer;

  @override
 void initState(){
    super.initState();
    pageController.addListener((){
      setState(() {
        _currPageValue = pageController.page!;
      });
    });

  }

  @override
  void dispose(){

    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //left right scroller
        GetBuilder <PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
            child:  PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position] );
                  })
          ):CircularProgressIndicator(color:AppColors.mainColor);
        }),
        GetBuilder <PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
          dotsCount: popularProducts.popularProductList.length<=0? 1: popularProducts.popularProductList.length,
          position: _currPageValue.toInt(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            activeColor: AppColors.mainColor,

          ),
        );}
        ),

        //recommended section
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width20),
              Container(
                margin: const EdgeInsets.only(bottom:5),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width20,),
              Container(
                margin: const EdgeInsets.only(bottom:5),
                child: SmallText(text: "Food pairing", color: Colors.black54),
              ),
              //popular items list
            ],
          )
        ),
        //recommended items
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width:Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius30),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ recommendedProduct.recommendedProductList[index].img!)
                              ),
                            ),
                          ),
                          //text section
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                    SizedBox(height: Dimensions.height10,),
                                    SmallText(text: "With chinese characteristics", color: Colors.black54),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Dimensions.height10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(icon: Icons.circle_sharp,
                                                text: "Normal", iconColor: AppColors.iconColor1),
                                            IconAndTextWidget(icon: Icons.location_on,
                                                text: "1.7km", iconColor: AppColors.mainColor),
                                            IconAndTextWidget(icon: Icons.access_time_rounded,
                                                text: "32min", iconColor: AppColors.iconColor2)
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                );
              }):
          CircularProgressIndicator(
              color:AppColors.mainColor);
        })
      ],

    );

  }
  //each element of the left right scroller
  Widget _buildPageItem (int index, ProductModel popularProduct){
    // conditions to handle the scaling of the scrollable items
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue-index) * (1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale,1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+ (_currPageValue-index+1) * (1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale,1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index) * (1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.9;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height* (1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

              Get.toNamed(RouteHelper.getPoplarFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ popularProduct.img!)
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color (0xFFE8E8E8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0),
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(5,0),
                      ),
                    ],
                ),
                child: Container(
                    padding: EdgeInsets.only(top:Dimensions.height15, left:Dimensions.height15, right:Dimensions.height15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: popularProduct.name!),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index)=> Icon(Icons.star, color: AppColors.mainColor, size:15)),
                            ),
                            SizedBox(width: Dimensions.width10),
                            SmallText(text:"4.5", color:Colors.black54),
                            SizedBox(width: Dimensions.width10),
                            SmallText(text:"1287",color: Colors.black54),
                            SizedBox(width: Dimensions.width10),
                            SmallText(text: "comments", color: Colors.black54)
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(icon: Icons.circle_sharp,
                                text: "Normal", iconColor: AppColors.iconColor1),
                            IconAndTextWidget(icon: Icons.location_on,
                                text: "1.7km", iconColor: AppColors.mainColor),
                            IconAndTextWidget(icon: Icons.access_time_rounded,
                                text: "32min", iconColor: AppColors.iconColor2)
                          ],
                        )
                      ],
                    ),
                )
            ),
          )
        ],
      ),
    );
  }
}
