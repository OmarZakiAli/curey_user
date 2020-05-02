import 'package:curey_user/screens/sign_up_screen/sign_up_field.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_botton.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _oldPassword = "";
  String _newPassword = "";
  TextEditingController _oldController = TextEditingController();
  TextEditingController _confController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        title: customBoldText(
            color: Colors.black, size: 16, text: "Change Password"),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              signUpFormField(context,
                  text: "Old Password",
                  cont: _oldController,
                  hint: "your password",
                  secure: true, validator: (String s) {
                _oldPassword = s;
                if (s.length < 8 && s.length != 0) {
                  return "too short";
                } else if (s.length > 50 && s.length != 0) {
                  return "too long";
                }
                return null;
              }),
              SizedBox(
                height: 20,
              ),
              signUpFormField(context,
                  text: "New Password",
                  cont: _newController,
                  hint: "your new password",
                  secure: true, validator: (String s) {
                _newPassword = s;
                if (s.length < 8 && s.length != 0) {
                  return "too short";
                } else if (s.length > 50 && s.length != 0) {
                  return "too long";
                }
                return null;
              }),
              SizedBox(
                height: 20,
              ),
              signUpFormField(context,
                  text: "Confirm Password",
                  cont: _confController,
                  hint: "password",
                  secure: true, validator: (String s) {
                if (s.length < 8 && s.length != 0) {
                  return "too short";
                } else if (s.length > 50 && s.length != 0) {
                  return "too long";
                }
                if (_newPassword != s) {
                  return "doesn,t match";
                }

                return null;
              }),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: customBoldText(text: "submit"),
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    print("change pass");
                  }
                },
              ),
            ],
          )),
    );
  }
}




