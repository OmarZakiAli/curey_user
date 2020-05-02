import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:curey_user/providers/medicatio_provider.dart';

class MedicationFilter extends StatefulWidget {
  @override
  _MedicationFilterState createState() => _MedicationFilterState();
}

class _MedicationFilterState extends State<MedicationFilter> {
  List<Keywords> _selected = [];
  int keyWordId;
  final List<String> _sortOptions = [
    "Price",
    "Name",
  ];
  int _sortOption = 0;

  @override
  Widget build(BuildContext context) {
    final _medProvider = Provider.of<MedicationProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                customBoldText(
                    text: "Filter",
                    size: 16,
                    color: Color(0xff242A37),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 12,
                ),
                _selected.length != 0
                    ? SizedBox(
                        height: _selected.length <= 3 ? 60 : 120,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 2),
                          children: <Widget>[
                            ..._selected.map((f) {
                              return commonItem(f);
                            }).toList()
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                customBoldText(
                    text: "Common Search",
                    size: 16,
                    color: Color(0xff242A37),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: _medProvider.keyWords.length != 0
                      ? calcHight(_medProvider.keyWords.length)
                      : 240,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 2),
                    children: <Widget>[
                      ..._medProvider.keyWords.map((f) {
                        return commonItem(f);
                      }).toList()
                    ],
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
              ],
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                _medProvider.filterbyKeyword(_selected, _sortOption);
                Navigator.of(context).pop();
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

  calcHight(int length) {
    if (length <= 3) {
      return 60.0;
    } else if (length > 3 && length <= 6) {
      return 120.0;
    } else if (length > 6 && length <= 9) {
      return 180.0;
    } else {
      return 240.0;
    }
  }

  commonItem(Keywords keywords) {
    bool isSelected = false;
    if (_selected.contains(keywords)) {
      isSelected = true;
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (_selected.contains(keywords)) {
            _selected.remove(keywords);
          } else {
            _selected.add(keywords);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff2291F2) : Color(0xffF1F2F6),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Center(
          child: customBoldText(
              text: keywords.name,
              size: 12,
              weight: FontWeight.w600,
              color: isSelected ? Colors.white : Color(0xff474C56)),
        ),
      ),
    );
  }
}

showMedicationFilter(BuildContext context) {
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MedicationFilter();
      });
}
