


import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';

dayItem({bool isSelected, String text, Function onTap}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 35,
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      child: Center(
        child: customNormalText(
          text: text,
          color: !isSelected ? Colors.blue : Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Color(0xffF3F4F8),
          borderRadius: BorderRadius.circular(5)),
    ),
  );
}
