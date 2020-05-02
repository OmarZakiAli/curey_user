import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';

buildNotificationItem(BuildContext context, int index) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(
                "assets/images/doc_ahmed.png",
              ),
            ),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  
                  children: <Widget>[
                    customBoldText(text: "Dr. Ahmed Ali",size: 14,color: Color(0xff242A37)),

                    customNormalText(text: " sent you a",size: 14,color: Color(0xff242A37)),
                    customNormalText(text: " Prescription",size: 14,color: Color(0xff07A3A4)),
                  ],
                ),

                  customNormalText(text: "24 ,jan",size: 12,color: Color(0xff7C7F87)),

              ],
            )
          ],
        ),
      ),
      Divider(color: Color(0x40AEAEAE),)
    ],
  );
}
