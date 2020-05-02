import 'package:curey_user/models/doctor_detail_model.dart';
import 'package:curey_user/providers/appointments_provider.dart';
import 'package:curey_user/providers/doc_details_provider.dart';
import 'package:curey_user/screens/booking_doctor_screen/date_item.dart';
import 'package:curey_user/screens/home_screen/home_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class BookingDoctorScreen extends StatefulWidget {
  final DoctorDetailModel docDetails;
  final bool isCallup;
  BookingDoctorScreen({Key key, this.docDetails, this.isCallup})
      : super(key: key);

  @override
  _BookingDoctorScreenState createState() => _BookingDoctorScreenState();
}

class _BookingDoctorScreenState extends State<BookingDoctorScreen> {
 

 
  final _todayGridController = ScrollController();
  final _tomorrowGridController = ScrollController();
  final _listController = ScrollController();
  bool _isToday = true;
  int _timeIndex=-1;
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final _app = Provider.of<AppointmentsProvider>(context, listen: false);
        final _doc = Provider.of<DoctorDetailsProvider>(context, listen: true);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      backgroundColor: Color(0xffF3F4F7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ListView(
                controller: _listController,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      customBoldText(
                          text: widget.isCallup
                              ? "Booking Home Visit"
                              : "Booking Appointment",
                          size: 18,
                          color: Color(0xff07A3A4)),
                      customBoldText(
                          text: widget.isCallup
                              ? "\$${widget.docDetails.doctor.callupFees.toString()}"
                              : "\$${widget.docDetails.doctor.fees.toString()}",
                          max: 6,
                          size: 16,
                          color: Color(0xff242A37)),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: Sizes.getWidth(100) * width,
                          height: 115,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/dr_sara.png"),
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
                                  text: widget.docDetails.doctor.fullName,
                                  size: 16,
                                  color: Color(0xff07A3A4)),
                              SizedBox(
                                height: 6,
                              ),
                              customNormalText(
                                  text: widget.docDetails.doctor.speciality,
                                  size: 12,
                                  color: Color(0xff242A37)),
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
                                      text: widget.docDetails.doctor.speciality,
                                      size: 11,
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
                                    rating:
                                        widget.docDetails.doctor.overallRating,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  customNormalText(
                                      text: widget.docDetails.reviews.length
                                          .toString(),
                                      size: 10,
                                      color: Color(0xff7C7F87))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  customBoldText(
                      textAlign: TextAlign.left,
                      text: "Today's Available Appointments",
                      size: 15,
                      color: Color(0xff474C56)),
                  SizedBox(
                    height: 16,
                  ),
                _doc.times==null?
                Center(child: CircularProgressIndicator(),):
                  _doc.times.firstDay.available.length==0?
                   Center(child: Text("no times available today"),)
                  :SizedBox(
                    height:  ((_doc.times.firstDay.available.length/3)+1)*40,
                    child:  GridView.builder(
                          controller: _todayGridController,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 16,
                              childAspectRatio: 2.5),
                          itemCount:  _doc.times.firstDay.available.length,
                          itemBuilder: (con, index) {
                            return buildDateItem(context,
                                date:  _doc.times.firstDay.available[index], onTap: () {
                              setState(() {
                                _isToday = true;
                                _timeIndex = index;
                              });
                            }, chosen: _isToday == true && _timeIndex == index);
                          },
                        )
                      
                    
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  customBoldText(
                      textAlign: TextAlign.left,
                      text: "Tomorrow's Available Appointments",
                      size: 15,
                      color: Color(0xff474C56)),
                  SizedBox(
                    height: 16,
                  ),
                   _doc.times.secondDay.available.length==0?
                   Center(child: Text("no times available today"),)
                 : SizedBox(
                    height:  ((_doc.times.secondDay.available.length/3)+1)*40,
                    child: GridView.builder(
                      controller: _tomorrowGridController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 16,
                          childAspectRatio: 2.5),
                      itemCount: _doc.times.secondDay.available.length,
                      itemBuilder: (con, index) {
                        return buildDateItem(context,
                            date: _doc.times.secondDay.available[index], onTap: () {
                          setState(() {
                            _isToday = false;
                            _timeIndex = index;
                          });
                        }, chosen: _isToday == false && _timeIndex == index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap:_timeIndex==-1?null: !isEnabled
                  ? null
                  : () {
                      setState(() {
                        isEnabled = false;
                      });

                      _app
                          .addAppointment(
                            id: int.parse(widget.docDetails.doctor.id),
                            isCallUp: widget.isCallup,
                            time: _isToday?"${_doc.times.firstDay.date} ${_doc.times.firstDay.available[_timeIndex]}":
                            "${_doc.times.secondDay.date} ${_doc.times.secondDay.available[_timeIndex]}"
                          )
                          .then((onValue) {
                            isEnabled=true;
                            Toast.show("success", context);
                             Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (con) => HomeScreen()),
      (Route<dynamic> route) => false);
                          });
                    },
              child: Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff07A3A4),
                ),
                child: Center(
                  child: customBoldText(
                    text: "Confirm Appointment",
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
