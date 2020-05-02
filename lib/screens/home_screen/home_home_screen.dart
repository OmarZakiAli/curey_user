import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/my_flutter_app_icons.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/cart_screen/cart_screen.dart';
import 'package:curey_user/screens/doctors_screen/doctors_screen.dart';
import 'package:curey_user/screens/medications_screen/medications_screen.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';

class HomeHomeScreen extends StatefulWidget {
  @override
  _HomeHomeScreenState createState() => _HomeHomeScreenState();
}

class _HomeHomeScreenState extends State<HomeHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

   LocalizationModel local=Provider.of<AuthProvider>(context,listen:false).local;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: buildAppDrawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: customBoldText(text: local.home, color: Colors.black, size: 20),
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
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: Sizes.getWidth(30) * width),
              child: customBoldText(
                  text: local.needHelp,
                  size: 17,
                  textAlign: TextAlign.left),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.only(left: Sizes.getWidth(30) * width),
              child: customBoldText(
                  text: local.findDm,
                  size: 24,
                  color: Color(0xff07A3A4),
                  textAlign: TextAlign.left),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 44,
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.getWidth(30) * width),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    hintText: local.searchDm,
                    hintStyle: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 13,
                        color: Color.fromRGBO(36, 42, 55, .4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color(0xff09CACB),
                      ),
                      onPressed: () {
                        print("search");
                        if (_searchController.value.text.toString() == "m") {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (con) {
                            return MedicationsScreen();
                          }));
                        } else {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (con) {
                            return DoctorsScreen();
                          }));
                        }
                      },
                    )),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => MedicationsScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/med.png"))),
                          height: 140,
                          width: 140,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DoctorsScreen()));
                        },
                        child: Container(
                          height: 140,
                          width: 140,
                          child: Image.asset("assets/images/sama3at_image.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
