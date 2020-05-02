import 'package:curey_user/models/doctor_model.dart';
import 'package:curey_user/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../consts.dart';

buildDoctorItem(BuildContext context, Doctors doc) {
 // print(doc.overallRating.rating);
  var width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    height: 130,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x42AEAEAE), width: 1),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.getWidth(16) * width, vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
                  child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/hassan.png",
                ),
                radius: Sizes.getWidth(40) * width,
              ),
              SizedBox(
                width: 18,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: customBoldText(
                            text: doc.fullName.length>25?doc.fullName.substring(0,22)+"...":doc.fullName
                            ,size: 14,
                            color: Color(0xff07A3A4))),
                    SizedBox(
                      height: 4,
                    ),
                    customNormalText(
                        text: doc.speciality.length>20?doc.speciality.substring(0,17)+"...":doc.speciality, size: 12, color: Colors.black),
                    SizedBox(
                      height: 4,
                    ),
                    Center(
                        child: SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: doc.overallRating,
                            size: 12.0,
                            color: Colors.yellow,
                            borderColor: Colors.green,
                            spacing: 0.0)),
                  ],
                ),
              ),
              Spacer(),
              customBoldText(
                  text: "${ double.parse(doc.fees)>1000 ?"1k>":doc.fees} \$", color: Colors.black, size: 14)
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: InkWell(
            onTap: () {
              print(doc.id.toString());

              Navigator.of(context).push(MaterialPageRoute(builder: (con) {
                return DoctorDetailsScreen(docId: doc.id,);
              }));
            },
            child: Container(
              width: Sizes.getWidth(120) * width,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xff09CACB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: customBoldText(
                      size: 14, text: "Choose", color: Colors.white)),
            ),
          ),
        )
      ],
    ),
  );
}
