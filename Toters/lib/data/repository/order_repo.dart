import 'package:get/get_connect/http/src/response/response.dart';
import 'package:toters/data/api/api_client.dart';
import 'package:toters/models/place_order_model.dart';
import 'package:toters/utils/app_constants.dart';

class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response>placeOrder(PlaceOrderBody placeOrder) async{
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }


  Future<Response>getOrderList()async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
  Future<Response>getOrderListDetail()async{
    return await apiClient.getData(AppConstants.ORDER_DETAIL_URI);
  }
}