import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toters/controllers/order_controller.dart';
import 'package:toters/models/order_model.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/styles.dart';

import '../../base/custom_loader.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading==false){
          late List<OrderModel> orderList;
          if(orderController.currentOrderList.isNotEmpty){
            orderList = isCurrent? orderController.currentOrderList.reversed.toList():
            orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context,index){
                    return InkWell(
                        onTap: (){
                          Get.toNamed(RouteHelper.getOrderDetail(orderList[index].id.toString()));
                        },
                        child: Column(
                          children: [
                            Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("order ID", style: TextStyle(fontSize: Dimensions.font14),),
                                          SizedBox(width: Dimensions.width30),
                                          Text("#"+ orderList[index].id.toString(), style: TextStyle(fontSize: Dimensions.font14)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.mainColor,
                                                borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                                                margin: EdgeInsets.all(Dimensions.height10/2),
                                                child: Text('${orderList[index].orderStatus}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                          ),
                                          SizedBox(height: Dimensions.height10/2),
                                          InkWell(
                                            onTap: ()=>null,
                                            child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10 ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                                    border: Border.all(width: 1, color: AppColors.mainColor)
                                                ),
                                                child: Row(
                                                  children: [
                                                    Image.asset("assets/image/tracking.png", height: Dimensions.height20, width: Dimensions.height20, color: AppColors.mainColor),
                                                    SizedBox(width: Dimensions.width10,),
                                                    Text("Track order ", style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w700),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                              ),

                            SizedBox(height: Dimensions.height10)
                          ],
                        )
                    );
                  }),
              ),
            );
          }else{
            return CustomLoader();
          }
      }),
    );
  }
}
