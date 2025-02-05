import 'package:shared_preferences/shared_preferences.dart';
import 'package:toters/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token=sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders={
      //data back from the server will be in jason format
      'Content-type':'application/json; charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders={
      //data back from the server will be in jason format
      'Content-type':'application/json; charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }


  Future<Response> getData(String uri,{Map<String, String>? headers}) async{
    try{
      Response response = await get(uri,
      headers: headers??_mainHeaders
      );
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    print(body.toString());
    try{
      print("waiting response");
      Response response= await post(uri, body, headers: _mainHeaders);
      print("response arrived");
      print(response.bodyString);
      return response;
    }catch(e){
      print("!!!Error is: "+e.toString());
      return Response (statusCode: 1, statusText: e.toString());
    }
  }
}
