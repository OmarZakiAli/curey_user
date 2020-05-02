import 'dart:ffi';

import 'package:curey_user/models/appointments_model.dart';
import 'package:curey_user/providers/appointments_provider.dart';
import 'package:curey_user/screens/appointments_screen/appointment_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _filter = 0;
  String tybe;
  List<AppointmentsModel> _toView = [];
  @override
  void initState() {
    final _app = Provider.of<AppointmentsProvider>(context, listen: false);
    if(_app.isFirst){
      _app.getAllAppointments();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _app = Provider.of<AppointmentsProvider>(context);

   
    if (_app.isLoading == false ) {
      if (_filter == 0) {
        _toView = _app.appointments;
      } else if (_filter == 1) {
        _toView = _app.appointments.where((f) {
          return !(f.isCallup || f.reExam);
        }).toList();
      } else if (_filter == 2) {
        _toView = _app.appointments.where((f) {
          return f.isCallup;
        }).toList();
      } else {
        _toView = _app.appointments.where((f) {
          return f.reExam;
        }).toList();
      }
    }

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildAppDrawer(),
      appBar: AppBar(
        title:
            customBoldText(text: "Appointments", color: Colors.black, size: 20),
        centerTitle: true,
        leading: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/hassan.png",
              ),
              radius: 20,
            ),
          ),
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff09CACB),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.getWidth(24) * width, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                appointmentTybe(
                    filter: 0,
                    text: "All",
                    marked: _filter == 0 ? true : false),
                appointmentTybe(
                    filter: 1,
                    text: "Booking",
                    marked: _filter == 1 ? true : false),
                appointmentTybe(
                    filter: 2,
                    text: "Home Visit",
                    marked: _filter == 2 ? true : false),
                appointmentTybe(
                    filter: 3,
                    text: "Re_Examination",
                    marked: _filter == 3 ? true : false),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            height: 2,
            color: Color(0x42AEAEAE),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: customBoldText(
                  text: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                  color: Color(0xf507A3A4),
                  size: 12,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.left),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: _app.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :_app.appointments.isEmpty? Center(child: Text("no appointments added yet"),):ListView.builder(
                    itemCount: _toView.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildAppointmentItem(context, _toView[index]);
                    },
                  ),
          )
        ],
      ),
    );
  }

  appointmentTybe({String text, int filter, bool marked = false}) {
    print(marked);
    return InkWell(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: customBoldText(
                  text: text, size: 15, color: Color(0x4D242A37))),
          Container(
            margin: EdgeInsets.only(top: 3),
            width: text.length * 7.0,
            height: 3,
            color: marked ? Color(0xff07A3A4) : Colors.white,
          )
        ],
      ),
      onTap: () {
        setState(() {
          _filter = filter;
        });
      },
    );
  }
}
