import 'package:curey_user/models/appointments_model.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

buildAppointmentItem(BuildContext con, AppointmentsModel app) {

 String tybe="";

   if(app.isCallup){
     tybe="Call Up";
   }else if(app.reExam){
     tybe="Re_Examination";
   }else{
     tybe="Booking";
   }

  var width = MediaQuery.of(con).size.width;
  return Container(
    width: width,
    height: 165,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x42AEAEAE), width: 1),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.getWidth(16) * width, vertical: 8),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/hassan.png",
                ),
                radius: Sizes.getWidth(35) * width,
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
                            text: app.fullName, size: 14, color: Colors.black,max: 25)),
                    SizedBox(
                      height: 4,
                    ),
                    Center(
                        child: customNormalText(
                            text: app.speciality,
                            max: 25,
                            size: 12,
                            color: Color(0x99242A37))),
                  ],
                ),
              ),

                        Spacer(),  
            customBoldText(text: tybe,color: Color(0xff2291F2),size: 12)

            ],
                
              


          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 2,
            color: Color(0x42AEAEAE),
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 11,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        customNormalText(text: app.appTime, size: 11),
                      ],
                    ),
                    SizedBox(
                      width: Sizes.getWidth(35) * width,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          size: 11,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        customNormalText(text: app.fees, size: 11,max: 6),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 11,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    customNormalText(
                        text: app.address, size: 11,max: 30),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
