import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:toters/data/repository/user_repo.dart';
import 'package:toters/models/response_model.dart';
import 'package:toters/models/user_model.dart';



class UserController extends GetxController implements GetxService {

  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isloading = false;
  late UserModel _userModel;

  bool get isLoading => _isloading;
  UserModel get userModel=>_userModel;

  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _isloading=true;
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }

}