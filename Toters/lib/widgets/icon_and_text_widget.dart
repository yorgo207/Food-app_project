import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toters/utils/dimensions.dart';
import 'package:toters/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({Key? key, required this.icon,
    required this.text,
    required this.iconColor}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24,),
        SizedBox(width: 5, ),
        SmallText(text: text, color: Colors.black54),
      ],
    );
  }
}
