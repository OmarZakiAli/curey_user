import 'package:curey_user/screens/profile_screen/change_number_sheet.dart';
import 'package:curey_user/screens/profile_screen/change_password_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: customBoldText(color: Colors.black, size: 16, text: "Account"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Center(child: customNormalText(text: "user name")),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              customNormalText(text: "01154795866"),
              InkWell(
                child: customNormalText(text: "change"),
                onTap: () {
                    showDialog(
                      
                      context: context, builder: (_){
                      return Dialog(child: ChangePhoneSheet());
                    });
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            child: customNormalText(text: "change password"),
            onTap: () {
              print("change pass");
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChangePasswordScreen()));
            },
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            child: customNormalText(text: "delete account"),
            onTap: () {
              print("delete account");
            },
          ),
        ],
      ),
    );
  }
}
