import 'package:get/get.dart';
import 'package:toters/data/repository/auth_repo.dart';
import 'package:toters/models/response_model.dart';
import 'package:toters/models/sign_in_body_model.dart';
import 'package:toters/models/sign_up_body_model.dart';

class AuthController extends GetxController implements GetxService{

  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isloading = false;
  bool get isLoading => _isloading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{
    _isloading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading=false;
    update();
    return responseModel;
  }
  Future<ResponseModel> login(SignInBodyModel signInBody) async{
    authRepo.getUserToken();
    _isloading = true;
    update();
    Response response = await authRepo.login(signInBody);
    late ResponseModel responseModel;
    if (response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      print("success");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusCode);
    }
    _isloading=false;
    update();
    return responseModel;
  }


  Future<void> saveUserNumberAndPassword(String number, String password) async {
   authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedDate();
  }
}