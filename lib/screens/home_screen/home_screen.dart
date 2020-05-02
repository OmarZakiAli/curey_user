import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/appointments_screen/appointments_screen.dart';
import 'package:curey_user/screens/notification_screen/notification_screen.dart';
import 'package:curey_user/screens/orders_screen/orders_screen.dart';
import 'package:curey_user/screens/prescreption_screen/prescription_screen.dart';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:curey_user/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';
import 'home_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _homeScreens = [
    HomeHomeScreen(),
    AppointmentsScreen(),
    PrescriptionScreen(),
    OrdersScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

@override
  void initState() {
    // TODO: implement initState
    _selectedIndex=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       LocalizationModel local=Provider.of<AuthProvider>(context,listen:false).local;

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffFCFCFC),
        ),
        Scaffold(
          backgroundColor: Color(0xffFCFCFC),
          body: _homeScreens.elementAt(_selectedIndex),
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBackgroundColor: Color(0xff09CACB),
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
              selectedItemTextStyle: TextStyle(fontSize: 9),
              unselectedItemTextStyle: TextStyle(fontSize: 9),
            ),
            selectedIndex: _selectedIndex,
            onSelectTab: (index) {
              _onItemTapped(index);
            },
            items: [
              FFNavigationBarItem(
                iconData: Icons.home,
                label: local.home,
              ),
              FFNavigationBarItem(
                iconData: CustomIcons.appointments,
                label: local.appointments,
              ),
              FFNavigationBarItem(
                iconData: CustomIcons.prescription,
                label: local.prescription,
              ),
              FFNavigationBarItem(
                iconData: CustomIcons.orders,
                label: local.orders,
              ),
              FFNavigationBarItem(
                iconData: Icons.notifications,
                label: local.notifications,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
