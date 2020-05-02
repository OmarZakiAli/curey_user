import 'package:curey_user/models/city_model.dart';
import 'package:curey_user/models/doctor_model.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/providers/doctor_provider.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DoctorFilter extends StatefulWidget {
  @override
  _DoctorFilterState createState() => _DoctorFilterState();
}

class _DoctorFilterState extends State<DoctorFilter> {
  final List<String> _sortOptions = [
    "Price",
    "Name",
  ];
  int _sortOption = 0;
  String _currentCity;
  int _cityId;

  Specialities _currentSpec;
  

  @override
  void initState() {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    final _docProvider = Provider.of<DoctorsProvider>(context, listen: false);
    if (_auth.cities.where((test) => test.id == -1).toList().isEmpty) {
      _auth.cities.insert(0, CityModel(name: "All Cities", id: -1));
    }
    if (_docProvider.specs.where((test) => test.id == -1).toList().isEmpty) {
      _docProvider.specs
          .insert(0, Specialities(name: "All Spesialities", id: -1));
    }
    _currentCity = "All Cities";
    _currentSpec = _docProvider.specs[0];
    _cityId = -1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    final _docProvider = Provider.of<DoctorsProvider>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),

                customBoldText(
                    text: "City & Specialty",
                    size: 16,
                    color: Color(0xff242A37),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  items: _auth.cities.map((CityModel city) {
                    return DropdownMenuItem(
                      value: city.name,
                      child: customNormalText(text: city.name),
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
                    });
                  },
                  value: _currentCity,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, left: 12),
                    hintText: "your city",
                    fillColor: Color(0xffFBFBFB),
                    focusColor: Color(0xffFBFBFB),
                    hoverColor: Color(0xffFBFBFB),
                    hintStyle: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 13,
                        color: Color.fromRGBO(36, 42, 55, .4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  items: _docProvider.specs.map((Specialities spec) {
                    return DropdownMenuItem(
                      value: spec.name,
                      child: customNormalText(text: spec.name),
                    );
                  }).toList(),
                  onChanged: (x) {
                    print(x);
                    setState(() {
                      _docProvider.specs.forEach((c) {
                        if (x == c.name) {
                          _currentSpec = c;
                        }
                      });
                    });
                  },
                  value: _currentSpec.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, left: 12),
                    hintText: "Speciality",
                    fillColor: Color(0xffFBFBFB),
                    focusColor: Color(0xffFBFBFB),
                    hoverColor: Color(0xffFBFBFB),
                    hintStyle: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 13,
                        color: Color.fromRGBO(36, 42, 55, .4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),
                customBoldText(
                    text: "Sort By",
                    size: 16,
                    color: Color(0xff242A37),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  items: _sortOptions.map((String op) {
                    return DropdownMenuItem(
                      value: op,
                      child: customNormalText(text: op),
                    );
                  }).toList(),
                  onChanged: (x) {
                    print(x);
                    setState(() {
                      _sortOption = _sortOptions.indexOf(x);
                      print(_sortOption.toString());
                    });
                  },
                  value: _sortOptions[_sortOption],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, left: 12),
                    hintText: "Sort",
                    fillColor: Color(0xffFBFBFB),
                    focusColor: Color(0xffFBFBFB),
                    hoverColor: Color(0xffFBFBFB),
                    hintStyle: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 13,
                        color: Color.fromRGBO(36, 42, 55, .4)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),

                // Spacer(),
              ],
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                _docProvider.filterbyCityandSpec(
                    spec: _currentSpec, cityId: _cityId,op: _sortOption);
                    
              },
              child: Container(
                width: 160,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff09CACB),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: customBoldText(
                        size: 14, color: Colors.white, text: "Apply")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

showDoctorFilter(BuildContext context) {
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DoctorFilter();
      });
}
