import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

buildDateItem(BuildContext context,
    {String date, Function onTap, bool chosen}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color:chosen?Color(0xff07A3A4): Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Center(
        child: customBoldText(
          text: date,
          size: 12,
          weight: FontWeight.w500,
          color: chosen?Colors.white: Color(0xff474C56),
        ),
      ),
    ),
  );
}
