import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/controllers/popular_product_controller.dart';
import 'package:toters/controllers/recommended_product_controller.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/widgets/small_text.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import 'food_page_body.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}
class _MainFoodPageState extends State<MainFoodPage> {

  Future<void>_loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
      children: [
        //showing header
        Container(
            child: Container(
                margin: EdgeInsets.only(top:Dimensions.height30, bottom:Dimensions.height15, left: Dimensions.width10, right: Dimensions.width10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText (text: "Lebanon", color: AppColors.mainColor, size: 25),
                        Row(
                          children: [
                            SmallText (text:"Ashrafieh", color: Colors.black54),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),

                    Center(
                        child: Container(
                          width: Dimensions.height45,
                          height: Dimensions.height45,
                          child: Icon (Icons.search, color: Colors.white, size:Dimensions.iconSize24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor,
                          ),
                        )
                    )
                  ],
                )
            )

        ),
        //showing scrollable middle
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        ))
      ],
    ),
        onRefresh: _loadResource);
  }
}
