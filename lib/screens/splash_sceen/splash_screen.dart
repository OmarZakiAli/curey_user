import 'dart:io';

import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/home_screen/home_screen.dart';
import 'package:curey_user/screens/onboard_screen/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var authProvider;

  @override
  void initState() {
   init();
    super.initState();
  }

  Future init() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    if (_shared.getString("token") != null) {
      print(_shared.getString("token"));
      await authProvider.init("en").then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (con) {
            return HomeScreen();
          }),
        );
      }, onError: (e) {
        showDialog(
            context: context,
            builder: (con) {
              return AlertDialog(
                               
                title: Text("Connection Problem"),
                content: Text(
                    "لا مؤاخذه في اللفظ لا مؤاخذه ف ايه في اللفظ...افتح نت و تعالي"),
              
              );
            }).then((x){
             exit(0);
            });

           
            
      });
    } else {
      await authProvider.init("en").then((value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con) {
          return OnboardSceen();
        }));
      }, onError: (e) {
        showDialog(
            context: context,
            builder: (con) {
              return AlertDialog(
                title: Text("Connection Problem"),
                content: Text(
                    "لا مؤاخذه في اللفظ لا مؤاخذه ف ايه في اللفظ...افتح نت و تعالي"),
              );
            }).then((onValue){
              exit(0);
            });
           setState(() {
             
           });            

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    authProvider = Provider.of<AuthProvider>(context);
    return Container(
      color: Color(0xff07A3A4),
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: Sizes.getWidth(100) * w,
          height: Sizes.getHeight(100) * h,
        ),
      ),
    );
  }
}
