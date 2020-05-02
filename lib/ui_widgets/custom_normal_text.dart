import 'package:flutter/material.dart';

Widget customNormalText({String text, Color color, double size,int maxlines=3,TextAlign textAlign=TextAlign.center,int max=200}) {
  return Text(
     text==null?"null": text.length<max?text:text.substring(0,max-4)+"...",
    maxLines: maxlines,
    textAlign: textAlign,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Gilroy",
    ),
  );
}
