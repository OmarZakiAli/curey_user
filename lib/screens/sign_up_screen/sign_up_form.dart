import 'package:curey_user/models/city_model.dart';
import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/models/sign_up_model.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/home_screen/home_screen.dart';
import 'package:curey_user/screens/sign_in_screen/sign_in_screen.dart';
import 'package:curey_user/screens/sign_up_screen/sign_up_field.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_botton.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _currentPassword = "";
  bool isAbled = true;

  int _cityId;
  String _currentCity;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currentCity = "Cairo";
    _cityId = 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    double w = MediaQuery.of(context).size.width;
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    LocalizationModel local = _auth.local;

    return Scaffold(
      body: !isAbled
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(7, 163, 164, 1),
                    Color.fromRGBO(9, 202, 203, 1)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Image.asset("assets/images/logo2.png",
                          height: 46,
                          width: Sizes.getWidth(140) * w,
                          fit: BoxFit.contain),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0x242A3726)),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        width: w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes.getWidth(40) * w),
                          child: ListView(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              signUpFormField(context,
                                  cont: _nameController,
                                  text: local.fullName,
                                  hint: local.uName,
                                  secure: false, validator: (String s) {
                                if (s.length < 8 && s.length != 0) {
                                  return "too short";
                                } else if (s.length > 50 && s.length != 0) {
                                  return "too long";
                                }

                                _auth.setUsername(s);
                                return null;
                              }),
                              signUpFormField(context,
                                  cont: _emailController,
                                  text: local.email,
                                  hint: local.uEmail,
                                  secure: false, validator: (String s) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(s);
                                bool isArab = RegExp(
                                        r"^[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufbc1]|[\ufbd3-\ufd3f]|[\ufd50-\ufd8f]|[\ufd92-\ufdc7]|[\ufe70-\ufefc]|[\uFDF0-\uFDFD]+")
                                    .hasMatch(s);
                                if (!EmailValidator.validate(s) &&
                                    s.length != 0 &&
                                    !emailValid) {
                                  return "write a valid email";
                                }

                                _auth.setUserEmail(s);

                                return null;
                              }),
                              SizedBox(
                                height: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: customBoldText(
                                        text: local.city,
                                        size: 12,
                                        weight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  DropdownButtonFormField(
                                    items: _auth.cities.map((city) {
                                      return DropdownMenuItem(
                                        value: city.name,
                                        child:
                                            customNormalText(text: city.name),
                                      );
                                    }).toList(),
                                    onChanged: (x) {
                                      print(x);
                                      setState(() {
                                        _auth.cities.forEach((c) {
                                          if (x == c.name) {
                                            _currentCity = c.name;
                                            _cityId = c.id;
                                          }
                                        });

                                        _auth.setUserCity(_cityId);
                                        print(_cityId);
                                      });
                                    },
                                    value: _currentCity,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 20, left: 12),
                                      hintText: local.city,
                                      fillColor: Color(0xffFBFBFB),
                                      focusColor: Color(0xffFBFBFB),
                                      hoverColor: Color(0xffFBFBFB),
                                      hintStyle: TextStyle(
                                          fontFamily: "Gilroy",
                                          fontSize: 13,
                                          color:
                                              Color.fromRGBO(36, 42, 55, .4)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ],
                              ),
                              signUpFormField(context,
                                  text: local.pass,
                                  cont: _passwordController,
                                  hint: local.uPass,
                                  secure: true, validator: (String s) {
                                _currentPassword = s;
                                if (s.length < 8 && s.length != 0) {
                                  return "too short";
                                } else if (s.length > 50 && s.length != 0) {
                                  return "too long";
                                }
                                return null;
                              }),
                              signUpFormField(context,
                                  text: local.cPass,
                                  cont: _confController,
                                  hint: local.pass,
                                  secure: true, validator: (String s) {
                                if (s.length < 8 && s.length != 0) {
                                  return "too short";
                                } else if (s.length > 50 && s.length != 0) {
                                  return "too long";
                                }
                                if (_currentPassword != s) {
                                  return "doesn,t match";
                                }

                                _auth.setUserPassword(s);

                                return null;
                              }),
                              SizedBox(
                                height: 30,
                              ),
                              customBotton(context,
                                  text: local.signup,
                                  onTap: !isAbled
                                      ? null
                                      : () {
                                          setState(() {
                                            isAbled = false;
                                          });
                                          if (_formKey
                                                  .currentState
                                                  .validate() &&
                                              _nameController.text.isNotEmpty &&
                                              _emailController
                                                  .text.isNotEmpty &&
                                              _passwordController
                                                  .text.isNotEmpty &&
                                              _confController.text.isNotEmpty) {
                                            print("validated");

                                            _auth
                                                .signUserUp()
                                                .then((String value) {
                                              if (value == "success") {
                                               isAbled=true;
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                SignInScreen()));
                                              } else {
                                                Toast.show(value, context);
                                                setState(() {
                                                  isAbled=true;
                                                });
                                              }
                                            });
                                          } else {
                                            Toast.show(
                                                "fill all fields with valid data",
                                                context);
                                                setState(() {
                                                  isAbled=true;
                                                });
                                          }
                                        },
                                  colorSchema: 1,
                                  width: 279,
                                  color: Color(0xff07A3A4)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  customNormalText(
                                    text: local.haveAcc,
                                    color: Color.fromRGBO(36, 42, 55, .35),
                                    size: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (con) => SignInScreen(),
                                      ));
                                    },
                                    child: customBoldText(
                                        text: local.signin,
                                        size: 12,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
