import 'package:flutter/material.dart';

Widget customBoldText(
    {String text, Color color, FontWeight weight, double size,TextAlign textAlign=TextAlign.center,int max=200}) {
  return Text(
   text==null?"null":  text.length<max?text:text.substring(0,max-4)+"...",
    maxLines: 3,
    textAlign: textAlign,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Gilroy",
      fontWeight: weight == null ? FontWeight.w700 : weight,
    ),
  );
}
