import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/app_icon.dart';
import 'package:toters/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({super.key, required this.appIcon, required this.bigText });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20,
        top:Dimensions.width20,
        bottom:Dimensions.width20,
      ),
      child:Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0,5),
              color: Colors.grey.withOpacity(0.2),
            )
          ]
      ),
    );
  }
}
