import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

import 'notification_item.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
     appBar: AppBar(
          title: customBoldText(text: "Notifications", color: Colors.black, size: 20),
          centerTitle: true,
          leading: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/hassan.png",
                ),
                backgroundColor: Colors.yellow,
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


        body: Padding(
          padding: const EdgeInsets.only(right:16.0,left: 16,top: 20),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (con,index){
              return buildNotificationItem(con,index);
            },
          ),
        ),



    );
  }
}