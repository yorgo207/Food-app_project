class AppConstants{
  static const String APP_Name="DBFood";
  static const int APP_VERSION=1;

  //if using local server use this Base url
  static const  String BASE_URL="http://10.0.2.2:8000";

  // if using online server use this Base url
  //static const String BASE_URL="http://food-app.byethost11.com";
  //static const String BASE_URL="http://ulfg2.great-site.net"

  static const String POPULAR_PRODUCT_URI="/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI="/api/v1/products/recommended";
  //static const String DRINKS_URI="/api/v1/products/drinks";
  static const String UPLOAD_URL= "/uploads/";

  //auth end points
  static const String REGISTRATION_URI="/api/v1/auth/register";
  static const String LOGIN_URI="/api/v1/auth/login";

  //user end point
  static const String USER_INFO_URI="/api/v1/customer/info";


  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST="cart-list";
  static const String CART_HISTORY_LIST="cart-hisoty-list";

  //order
  static const String payment="/payment";
  static const String orderSuccess="/order-successful";
  static const String PLACE_ORDER_URI="/api/v1/customer/order/place";
  static const String ORDER_LIST_URI="/api/v1/customer/order/list";
  static const String ORDER_DETAIL_URI="/api/v1/customer/order/details";


}