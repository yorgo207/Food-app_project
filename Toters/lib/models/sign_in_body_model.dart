class SignInBodyModel{

  String phone;
  String password;

  SignInBodyModel({
    required this.phone, required this.password,
  });

  Map<String, dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["phone"]=this.phone;
    data["password"]=this.password;
    return data;
  }
}