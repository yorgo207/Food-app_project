import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText ({Key? key, this.color = const Color (0xFF332d2b), required this.text,
    this.overflow=TextOverflow.ellipsis, this.size=0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: size==0? Dimensions.font20 : size,
      )
    );
  }
}
