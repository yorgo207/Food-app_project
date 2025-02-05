import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/widgets/big_text.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;

  const CustomAppBar({super.key, required this.title, this.backButtonExist=true, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      title: BigText(text: title, color:Colors.white),
      centerTitle: true,
      leading: backButtonExist?IconButton
        (onPressed: ()=>onBackPressed!=null?onBackPressed!():
          Navigator.pushReplacementNamed(context, "/initial"),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        ):Container(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(500,50);
}
