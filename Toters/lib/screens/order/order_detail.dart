import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/base/custom_app_bar.dart';
import 'package:toters/models/order_detail_model.dart';
import 'package:toters/models/order_model.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/dimensions.dart';

import '../../base/custom_loader.dart';
import '../../controllers/order_controller.dart';

class OrderDetail extends StatefulWidget {
  final String orderId;
  OrderDetail({super.key, required this.orderId});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late List<OrderDetailModel> currentOrder;

  @override
  void initState() {
    super.initState();
    currentOrder = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Order number # ${widget.orderId}"),
      body: Column(
        children: [
          GetBuilder<OrderController>(
              builder: (orderController) {
                // When data is loaded and is not empty
                if (orderController.isLoading == false) {
                  currentOrder = orderController.orderDetailList
                      .where((detail) => detail.orderId.toString() == widget.orderId)
                      .toList();
                  double totalSum = 0;
                  currentOrder.forEach((orderDetail) {
                    totalSum += orderDetail.price! * orderDetail.quantity!;


                  });

                  return Expanded(
                    child: Column(
                      children: [
                        // ListView.builder to display order details
                        Expanded(
                          child: ListView.builder(
                            itemCount: currentOrder.length,
                            itemBuilder: (context, index) {
                              final orderDetail = currentOrder[index];
                              Map<String, dynamic> data = jsonDecode(orderDetail.foodDetails!);
                              return Container(
                                padding: EdgeInsets.all(Dimensions.height15),
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2), blurRadius: 8.0)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: TextStyle(fontSize: Dimensions.font16+2, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: Dimensions.font16/2),
                                    Text('Quantity: ${orderDetail.quantity}', style: TextStyle(fontSize: Dimensions.font16)),
                                    Text('Price: \$${orderDetail.price?.toStringAsFixed(2)}', style: TextStyle(fontSize: Dimensions.font16)),
                                    Text('Tax: \$${orderDetail.taxAmount?.toStringAsFixed(2)}', style: TextStyle(fontSize: Dimensions.font16)),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total', style: TextStyle(fontSize: Dimensions.font16)),
                                        Text('\$${(orderDetail.price! * orderDetail.quantity!).toStringAsFixed(2)}', style: TextStyle(fontSize: 16.0)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Container to show the total sum after the list
                        Container(
                          padding: EdgeInsets.all(Dimensions.height15),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius15),
                              topRight: Radius.circular(Dimensions.radius15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Sum:',
                                style: TextStyle(
                                  fontSize: Dimensions.font26,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              // Directly display the updated totalSum
                              Text(
                                '\$${totalSum.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: Dimensions.font26,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CustomLoader(); // Show loader while loading
                }
              }
          ),
        ],
      ),
    );
  }
}
