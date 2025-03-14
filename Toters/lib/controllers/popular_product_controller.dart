import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:toters/controllers/cart_controller.dart';
import 'package:toters/data/repository/popular_product_repo.dart';
import 'package:toters/models/cart_model.dart';
import 'package:toters/models/products_model.dart';
import 'package:toters/utils/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isloaded = false;
  bool get isLoaded => _isloaded;

  int _quantity=0;
  int get quantity =>_quantity;

  int _inCartItems=0;
  int get inCartItems => _inCartItems+_quantity;

  PopularProductController({required this.popularProductRepo});

  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    print("getting data");
    if (response.statusCode==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isloaded=true;
      update();

    }else{
      //print("hello:"+ response.statusCode.toString());
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(quantity+1);
    }else{
      _quantity=checkQuantity(quantity-1);
    }
    update();
  }


  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Minimum amount reached", "You can't reduce more!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Maximum amount reached", "You can't add more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart = cart;
    var exist = false;
    exist=_cart.existInCart(product);
    //if exist
    //get from storage _inCartItems
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    //print("quantity in the cart is"+ _inCartItems.toString());
  }

  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);

      _quantity=0;
      _inCartItems= _cart.getQuantity(product);

      _cart.items.forEach((key, value){
        print("id: "+value.id.toString()+ "quantity: "+ value.quantity.toString());
      });
      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}