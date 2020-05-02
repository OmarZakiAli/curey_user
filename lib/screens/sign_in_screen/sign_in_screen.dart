import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/home_screen/home_screen.dart';
import 'package:curey_user/screens/sign_up_screen/sign_up_field.dart';
import 'package:curey_user/screens/sign_up_screen/sign_up_form.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_botton.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curey_user/consts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isAbled = true;
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    LocalizationModel local = _auth.local;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: !isAbled
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, ((Sizes.getHeight(86) * h) - statusBarHeight), 0, 0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(7, 163, 164, 1),
                      Color.fromRGBO(9, 202, 203, 1)
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Center(
                        child: Image.asset("assets/images/logo2.png",
                            height: 46,
                            width: Sizes.getWidth(140) * w,
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text(local.wel,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                      ),
                      Text(
                        local.signAccount,
                        style: TextStyle(
                            color: Color.fromRGBO(236, 252, 255, 1),
                            fontSize: 16,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.normal),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 24),
                          padding: EdgeInsets.only(
                              top: 48,
                              right: Sizes.getWidth(48) * w,
                              left: Sizes.getWidth(48) * w,
                              bottom: 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white,
                          ),
                          child: ListView(
                            children: <Widget>[
                              signUpFormField(context,
                                  cont: _emailController,
                                  hint: local.uEmail,
                                  text: local.email, validator: (String s) {
                                if (!EmailValidator.validate(s) &&
                                    s.length != 0) {
                                  return "write a valid email";
                                }
                                _auth.setUserEmail(s);
                              }, secure: false),
                              signUpFormField(context,
                                  text: local.uPass,
                                  cont: _passwordController,
                                  hint: local.ePass,
                                  secure: true, validator: (String s) {
                                if (s.length < 8 && s.length != 0) {
                                  return "too short";
                                } else if (s.length > 50 && s.length != 0) {
                                  return "too long";
                                }
                                _auth.setUserPassword(s);
                                return null;
                              }),
                              SizedBox(
                                height: 24,
                              ),
                              InkWell(
                                onTap: () {
                                  print("forget password");
                                },
                                child: customNormalText(
                                    size: 12,
                                    text: local.fPass,
                                    color: Color.fromRGBO(242, 5, 68, 1)),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              customBotton(context,
                                  text: local.signin,
                                  onTap: !isAbled
                                      ? null
                                      : () {
                                          setState(() {
                                            isAbled = false;
                                          });
                                          if (_formKey.currentState
                                                  .validate() &&
                                              _passwordController
                                                  .text.isNotEmpty &&
                                              _emailController
                                                  .text.isNotEmpty) {
                                            _auth.signUserIn().then((value) {
                                              if (value == "Succees") {
                                                isAbled = true;
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                HomeScreen()));
                                              } else {
                                                Toast.show(value, context);
                                                setState(() {
                                                  isAbled = true;
                                                });
                                              }
                                            });
                                          } else {
                                            Toast.show(
                                                "enter valid data !", context);
                                            setState(() {
                                              isAbled = true;
                                            });
                                          }
                                        }),
                              Padding(
                                padding: EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      local.dontHave,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(36, 42, 55, .35),
                                          fontSize: 12,
                                          fontFamily: "Gilroy",
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print("Sign Up");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (c) {
                                          return SignUpForm();
                                        }));
                                      },
                                      child: customNormalText(
                                          size: 12,
                                          text: local.signup,
                                          color:
                                              Color.fromRGBO(9, 202, 203, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
    );
  }
}
