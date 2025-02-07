import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/auth/sign_up_page.dart';
import 'package:toters/base/custom_loader.dart';
import 'package:toters/base/show_custom_snackbar.dart';
import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/models/sign_in_body_model.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/app_text_field.dart';
import 'package:toters/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();


    void _login(AuthController authController){
      String phone= phoneController.text.trim();
      String password= passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Enter your phone number", title: "Phone number");
      }else if(password.isEmpty){
        showCustomSnackBar("Enter your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password must be greater than 6 characters", title: "Password");
      }else{
        SignInBodyModel signInBody= SignInBodyModel(
            phone: phone, password: password);
        authController.login(signInBody).then((status){
          if (status.isSuccess){
            Get.toNamed(RouteHelper.getInitial(pageId: 3));
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading?SingleChildScrollView(
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

                //welcome
                Container(
                    margin:EdgeInsets.only(left: Dimensions.width20) ,
                    child: Column(
                      children: [
                        Text("Hello",
                            style: TextStyle(
                              fontSize: Dimensions.font20*3+Dimensions.font20/2,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        Text("Sign into your account",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                            )
                        )
                      ],
                    )
                ),
                SizedBox(height: Dimensions.height30,),
                //phone
                AppTextField(textController: phoneController, hintText: "Phone", icon:Icons.phone),
                SizedBox(height: Dimensions.height20,),
                //pass
                AppTextField(textController: passwordController, hintText: "Password", icon:Icons.password_sharp, isObscure: true,),
                SizedBox(height: Dimensions.height20,),

                Row(
                  children: [
                    SizedBox(width: Dimensions.width30*15,),
                    RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height30,),

                //sign in button
                GestureDetector(
                  onTap: (){
                    _login(authController);

                  },
                  child:  Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color:AppColors.mainColor,
                    ),
                    child: Center(
                      child: BigText(text: "Sign in",
                        size: Dimensions.font20+Dimensions.font20/2, color:Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),

                SizedBox(height: Dimensions.height30,),

                //sign up
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                    children:[
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                        text: "Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ):CustomLoader();
        })
    );
  }
}
