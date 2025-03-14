import 'package:get/get.dart';


// scaling factor: 844/val or 390

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //dynamic height
  static double pageView=screenHeight/2.64;
  static double pageViewContainer= screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;

  static double height10= screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20= screenHeight/42.2;
  static double height30=screenHeight/28.13;
  static double height35=screenHeight/21.11;
  static double height45=screenHeight/18.76;

  //dynamic fonts
  static double font14= screenHeight/60.28;
  static double font16 = screenHeight/52.75;
  static double font20= screenHeight/42.2;
  static double font26=screenHeight/32.46;

  static double radius15=screenHeight/56.27;
  static double radius20=screenHeight/42.2;
  static double radius30=screenHeight/28.13;

  //dynamic width
  static double width10= screenWidth/84.4;
  static double width15 = screenWidth/56.27;
  static double width20= screenWidth/42.2;
  static double width30=screenWidth/28.13;

  //icon size
  static double iconSize20=screenHeight/42.2;
  static double iconSize24=screenHeight/35.17;
  static double iconSize16=screenHeight/52.75;


  //list view size
  static double listViewImgSize = screenWidth/3.25;
  static double listViewTextContSize = screenWidth/3.9;

  //popular food
  static double popularFoodImgSize= screenHeight/2.41;

  //bottom height
static double bottomHeightBar=screenHeight/7.03;
}