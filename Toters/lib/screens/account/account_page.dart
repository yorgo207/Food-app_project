import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toters/base/custom_loader.dart';
import 'package:toters/controllers/auth_controller.dart';
import 'package:toters/controllers/cart_controller.dart';
import 'package:toters/controllers/user_controller.dart';
import 'package:toters/routes/route_helper.dart';
import 'package:toters/utils/colors.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/account_widget.dart';
import 'package:toters/widgets/app_icon.dart';
import 'package:toters/widgets/big_text.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: Dimensions.font26, color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(!userController.isLoading?
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top:Dimensions.height20),
          child: Column(
            children: [
              AppIcon(icon: Icons.person, backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white, iconSize:Dimensions.iconSize24*4, size: Dimensions.height15*10
              ),
              SizedBox(height:Dimensions.height30),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //name
                          AccountWidget(
                            appIcon: AppIcon(icon: Icons.person, backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel.name, size: Dimensions.font26),
                          ),
                          SizedBox(height: Dimensions.height20,),
                          //phone
                          AccountWidget(
                            appIcon: AppIcon(icon: Icons.phone, backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel.phone, size: Dimensions.font26),
                          ),
                          SizedBox(height: Dimensions.height20,),
                          //email
                          AccountWidget(
                            appIcon: AppIcon(icon: Icons.email, backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel.email, size: Dimensions.font26),
                          ),
                          SizedBox(height: Dimensions.height20,),
                          //address
                          AccountWidget(
                            appIcon: AppIcon(icon: Icons.location_on, backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Ashrafieh", size: Dimensions.font26),
                          ),
                          SizedBox(height: Dimensions.height20,),
                          //message
                          AccountWidget(
                            appIcon: AppIcon(icon: Icons.message_outlined, backgroundColor: Colors.redAccent,
                              iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Messages", size: Dimensions.font26),
                          ),
                          SizedBox(height: Dimensions.height20,),

                          //logout
                          GestureDetector(
                            onTap: (){
                              if(Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clearCartHistory();
                                Get.toNamed(RouteHelper.getInitial(pageId: 0));
                              }else{
                                print("you are logged out");
                                Get.snackbar("User Not Signed In", "You are already logged out");
                              }
                            },
                            child: AccountWidget(
                              appIcon: AppIcon(icon: Icons.logout, backgroundColor: Colors.redAccent,
                                iconColor: Colors.white, iconSize:Dimensions.height10*5/2, size: Dimensions.height10*5,
                              ),
                              bigText: BigText(text: "Log Out", size: Dimensions.font26),
                            ),
                          ),
                          SizedBox(height: Dimensions.height20,),
                        ],
                      )
                  )

              )
            ],
          ),
        ):CustomLoader()):
        Container(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height30*10,
                margin: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:AssetImage("assets/image/NotLoggedIn.jpg") )
                ),
              ),
              SizedBox(height: Dimensions.height20),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());
                },
                child:Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(child:BigText(text: "Sign in", color: Colors.white, size: Dimensions.font26,),)
                ),
              )
            ],
          )
          
        ));
      })
    );
  }
}

