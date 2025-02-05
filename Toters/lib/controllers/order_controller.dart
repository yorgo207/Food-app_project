import 'dart:convert';

import 'package:get/get.dart';
import 'package:toters/models/order_detail_model.dart';
import 'package:toters/models/place_order_model.dart';
import 'package:toters/screens/order/order_detail.dart';

import '../data/repository/order_repo.dart';
import '../models/order_model.dart';


class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading=>_isLoading;
  late List<OrderModel> _currentOrderList;
  late  List<OrderModel> _historyOrderList;
  late List<OrderDetailModel> _orderDetailList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;
  List<OrderDetailModel> get orderDetailList => _orderDetailList;

  /*Future<void>placeOrder(PlaceOrderBody placeOrder, Function callback) async{
    _isLoading=true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode ==200){
      _isLoading=false;
      String message = response.body['message'];
      String orderID = response. body['order_id'].toString();
      callback(true, message, orderID );
    }else{
      callback(false, response.statusText!,'-1');
    }
  }*/
  Future<void>placeOrder(PlaceOrderBody placeOrder) async{
    _isLoading=true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode ==200) {
      _isLoading = false;
      print(response.statusCode);
     print("success!!!");
    }else{
      print("fail:"+ response.statusCode.toString()!);
      print("fail:"+ response.statusText!);
      print("fail:"+ response.body.toString());

    }
    _isLoading=false;
  }

  Future<void> getOrderList() async{
    _isLoading=true;

    Response response= await orderRepo.getOrderList();
    if(response.statusCode==200){
      _historyOrderList = [];
      _currentOrderList=[];
      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus=='pending' || orderModel.orderStatus=='accepted' ||
            orderModel.orderStatus=='processing'|| orderModel.orderStatus=='handover' ||
            orderModel.orderStatus=='picked_up'){
            _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      });
    }else{
      _historyOrderList=[];
      _currentOrderList=[];
    }
    _isLoading=false;
    print("out:" +_currentOrderList.length.toString());
    getOrderListDetail();
    update();
  }
  

  Future<List<OrderDetailModel>> getOrderListDetail() async{
    _isLoading=true;
    print("getting detail");
    _orderDetailList=[];
    Response response= await orderRepo.getOrderListDetail();
    if(response.statusCode==200){
        print("success");
        response.body.forEach((orderDetail){
          OrderDetailModel orderDetailModelModel = OrderDetailModel.fromJson(orderDetail);
          _orderDetailList.add(orderDetailModelModel);
        });
    }else{
      print("fail");
      print(response.bodyString);
    }

    _isLoading=false;
    update();
    return _orderDetailList;
  }

}