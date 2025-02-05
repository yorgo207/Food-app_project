import 'dart:convert';

import 'package:toters/models/cart_model.dart';
import 'package:toters/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{

  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList){

    var time = DateTime.now().toString();
    cart=[];
    cartList.forEach((element){
      element.time=time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartList(){
    List <String> carts=[];
    if( sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts= sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      //print(carts.toString());
    }
    List<CartModel> cartList=[];
    carts.forEach((element){
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    carts.forEach((element)=> cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory=[];
    cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void AddToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    //print(getCartHistoryList().length.toString());
    //print(getCartHistoryList()[0].time.toString());
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
  void removeCartSharedPreferences(){
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
