import 'package:curey_user/models/doctor_detail_model.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

buildReviewItem(BuildContext comtext, Reviews rev) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    margin: EdgeInsets.only(bottom: 16,right: 12,left: 12),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/images/dr_sara.png"),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              children: <Widget>[
                customBoldText(
                    text: rev.fullName, size: 14, color: Color(0xff242A37),max: 25),
                SizedBox(
                  height: 6,
                ),
                customNormalText(
                    text: "Today", size: 10, color: Color(0xff7C7F87)),
              ],
            ),
            Spacer(),
            SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: rev.rating/2.0,
                size: 12.0,
                color: Colors.yellow,
                borderColor: Colors.green,
                spacing: 0.0),
          ],
        ),
        SizedBox(height: 8,),
        customNormalText(
            color: Color(0xff7C7F87),
            size: 12,
            textAlign: TextAlign.left,
            text:rev.review,
            max: 150
            ),

      ],
    ),
  );
}
