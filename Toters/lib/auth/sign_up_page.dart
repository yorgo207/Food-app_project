import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/base/custom_loader.dart';
import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/app_text_field.dart';
import 'package:toters/widgets/big_text.dart';
import 'package:toters/base/show_custom_snackbar.dart';
import'package:toters/models/sign_up_body_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages=[
      "t.png", "f.png", "g.png"
    ];

    void _registration(AuthController authController){
      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String password= passwordController.text.trim();
      String email= emailController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Enter your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Enter your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Enter your email address", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Use a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Enter your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password must be greater than 6 characters", title: "Password");
      }else{
        SignUpBody signUpBody= SignUpBody(name: name, phone: phone,
            email: email, password: password);
        authController.registration(signUpBody).then((status){
          if (status.isSuccess){
            print("Success Registration");
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return  !_authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //logo
              Container(
                  height: Dimensions.screenHeight*0.25,
                  child: Center(
                    child:CircleAvatar(
                      radius: Dimensions.radius30*3,
                      backgroundColor:Colors.white,
                      backgroundImage: AssetImage("assets/image/TotersLogo.jpg"),
                    ),
                  )
              ),
              //email
              AppTextField(textController: emailController, hintText: "Email", icon:Icons.email),
              SizedBox(height: Dimensions.height20,),
              //pass
              AppTextField(textController: passwordController, hintText: "Password", icon:Icons.password_sharp, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              //name
              AppTextField(textController: nameController, hintText: "Name", icon:Icons.person),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(textController: phoneController, hintText: "Phone", icon:Icons.phone),
              SizedBox(height: Dimensions.height20*2,),

              //Sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color:AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2, color:Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),

              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.035),

              //sign up options
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    )
                ),
              ),


              Wrap(
                children: List.generate(3, (index)=> Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius:Dimensions.radius30,
                    backgroundImage:AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                ),
                ),
              )
            ],
          ),
        ):CustomLoader();
      })
    );


  }

}
