import 'dart:ffi';

import 'package:curey_user/models/order_model.dart';
import 'package:curey_user/providers/appointments_provider.dart';
import 'package:curey_user/providers/orders_provider.dart';
import 'package:curey_user/screens/appointments_screen/appointment_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import 'order_item.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}
  
class _OrdersScreenState extends State<OrdersScreen> {
  int _filter = 0;
  String tybe;
  List<Orders> _toView = [];
  @override
  void initState() {
    final _ord = Provider.of<OrdersProvider>(context, listen: false);
   if(_ord.isFirst){
       _ord.getAllOrders();
    }
     
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
        final _ord = Provider.of<OrdersProvider>(context, listen: true);
_toView=_ord.order.orders;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildAppDrawer(),
      appBar: AppBar(
        title:
            customBoldText(text: "Orders", color: Colors.black, size: 20),
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
      body: _ord.isLoading?Center(child: CircularProgressIndicator(),):
         _ord.order.orders.isEmpty?
         Center(
           child: customNormalText(text:"error retrieving orders"),
         )
        :Column(
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
                    text: "Delivered",
                    marked: _filter == 1 ? true : false),
                appointmentTybe(
                    filter: 2,
                    text: "Pending",
                    marked: _filter == 2 ? true : false),
                appointmentTybe(
                    filter: 3,
                    text: "Failed",
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
         
          Expanded(
            child: ListView.builder(
              itemCount: _toView.length,
              itemBuilder: (BuildContext context, int index) {
                return buildOrderItem(context,_toView[index]);
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
