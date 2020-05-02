import 'package:flutter/material.dart';

import '../consts.dart';
import 'custom_bold_text.dart';

Widget customBotton(BuildContext context,
    {String text,
    int colorSchema = 1,
    Function onTap,
    Color color,
    double width = 156}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Sizes.getWidth(width) * MediaQuery.of(context).size.width,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: colorSchema == 1 ? Colors.white : Color(0xff09CACB)),
        color: color == null
            ? colorSchema == 1 ? Color(0xff09CACB) : Colors.white
            : color,
      ),
      child: Center(
        child: customBoldText(
            text: text,
            color: colorSchema == 1 ? Colors.white : Color(0xff07A3A4)),
      ),
    ),
  );
}
