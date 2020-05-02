import 'package:curey_user/models/doctor_detail_model.dart';
import 'package:curey_user/providers/appointments_provider.dart';
import 'package:curey_user/screens/booking_doctor_screen/booking_doctor_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../consts.dart';

class DoctorHeader extends SliverPersistentHeaderDelegate {
  final DoctorDetailModel docDetails;

  DoctorHeader(this.docDetails);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(right: 18, left: 18, top: 8),
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: Sizes.getWidth(100) * width,
                height: 115,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/dr_sara.png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    customBoldText(
                        text: docDetails.doctor.fullName,
                        size: 16,
                        color: Color(0xff07A3A4),
                        max: 25),
                    SizedBox(
                      height: 6,
                    ),
                    customNormalText(
                        text: docDetails.doctor.speciality,
                        size: 12,
                        color: Color(0xff242A37),
                        max: 25),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        customNormalText(
                            text: docDetails.doctor.address,
                            size: 11,
                            max: 25,
                            color: Color(0xffAEAEAE)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SmoothStarRating(
                          borderColor: Colors.yellow,
                          color: Colors.yellow,
                          allowHalfRating: true,
                          starCount: 5,
                          rating: 3.5 - .1,
                          size: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        customNormalText(
                            text:
                                "${docDetails.reviews.length.toString()} reviews",
                            size: 10,
                            color: Color(0xff7C7F87))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            customNormalText(
                                text: "Booking",
                                size: 10,
                                color: Color(0XFF474C56)),
                            customBoldText(
                                text: docDetails.doctor.fees,
                                size: 16,
                                color: Color(0xff242A37),
                                max: 5)
                          ],
                        ),
                        SizedBox(
                          width: Sizes.getWidth(70) * width,
                        ),
                        Column(
                          children: <Widget>[
                            customNormalText(
                                text: "Home visit",
                                size: 10,
                                color: Color(0XFF474C56)),
                            customBoldText(
                                text: docDetails.doctor.offersCallup
                                    ? docDetails.doctor.callupFees
                                    : "no",
                                size: 16,
                                color: Color(0xff242A37),
                                max: 5)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return BookingDoctorScreen(docDetails: docDetails,isCallup:false);
                  }));
                },
                child: Container(
                  width: Sizes.getWidth(140) * width,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff07A3A4),
                  ),
                  child: Center(
                    child: customNormalText(
                        text: "Book now",
                        color: Colors.white,
                        max: 15),
                  ),
                ),
              ),
              
                  InkWell(
                    onTap:!docDetails.doctor.offersCallup?null: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return BookingDoctorScreen(docDetails: docDetails,isCallup:true);
                  }));    
                    },
                    child: Container(
                      width: Sizes.getWidth(140) * width,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff09CACB),
                      ),
                      child: Center(
                        child: customNormalText(
                          max: 15,
                            text:docDetails.doctor.offersCallup? "Home visit":"Unavailable", color: Colors.white),
                            
                      ),
                    ),
                  )
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 230;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
