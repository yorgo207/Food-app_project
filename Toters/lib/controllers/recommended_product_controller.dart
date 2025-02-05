import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isloaded = false;
  bool get isLoaded => _isloaded;

  RecommendedProductController({required this.recommendedProductRepo});

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode==200){
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isloaded=true;
      update();
    }else{

    }
  }


}