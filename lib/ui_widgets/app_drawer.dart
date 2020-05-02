import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/cart_screen/cart_screen.dart';
import 'package:curey_user/screens/favourites_screen.dart/favourites_screen.dart';
import 'package:curey_user/screens/profile_screen/profile_screen.dart';
import 'package:curey_user/screens/sign_in_screen/sign_in_screen.dart';
import 'package:curey_user/screens/sign_up_screen/sign_up_form.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'custom_bold_text.dart';

class buildAppDrawer extends StatefulWidget {
  @override
  _buildAppDrawerState createState() => _buildAppDrawerState();
}

class _buildAppDrawerState extends State<buildAppDrawer> {
  bool _isEnabled = true;

  @override
  void initState() {
    _isEnabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.only(left: 20, top: 30, right: 15),
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xff08BEBF), width: 2)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/hassan.png"),
                    radius: 35,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  children: <Widget>[
                    customBoldText(
                        text: "user_ name",
                        max: 16,
                        size: 16,
                        color: Color(0Xff07A3A4)),
                    SizedBox(
                      height: 10,
                    ),
                    customNormalText(
                        text: "Complete your profile",
                        size: 10,
                        color: Color(0xff7C7F87)),
                  ],
                ),
              ],
            ),
            Container(
              height: 1,
              color: Color(0x42AEAEAE),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ProfileScreen(),
                  ));
                },
                child: customBoldText(
                    text: "Account", textAlign: TextAlign.left, size: 15)),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 1,
              color: Color(0x42AEAEAE),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            SizedBox(
              height: 7,
            ),
            customBoldText(
                text: "Settings", textAlign: TextAlign.left, size: 15),
            Container(
              height: 1,
              color: Color(0x42AEAEAE),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CartScreen(),
                  ));
                },
                child: customBoldText(
                    text: "Shopping cart", textAlign: TextAlign.left)),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FavouritesScreen(),
                ));
              },
              child: customBoldText(text: "Saves", textAlign: TextAlign.left),
            ),
            Container(
              height: 1,
              color: Color(0x42AEAEAE),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            InkWell(
                onTap: !_isEnabled
                    ? null
                    : () {
                        setState(() {
                          _isEnabled = false;
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .logOut()
                            .then((_) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (con) => SignInScreen()),
                              (Route<dynamic> route) => false);
                        }, onError: (e) {
                          Toast.show(e.toString(), context);
                          setState(() {
                            _isEnabled = true;
                          });
                        });
                      },
                child: customBoldText(
                    text: "Log out",
                    textAlign: TextAlign.left,
                    color: Color(0xff7C7F87))),
          ],
        ),
      ),
    );
  }
}
