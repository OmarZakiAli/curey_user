import 'package:curey_user/dialogs/medication_filter.dart';
import 'package:curey_user/providers/favourites_provider.dart';
import 'package:curey_user/providers/medicatio_provider.dart';
import 'package:curey_user/screens/doctors_screen/doctor_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curey_user/dialogs/warning_dialog.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';
import 'medication_item.dart';

class MedicationsScreen extends StatefulWidget {
  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  final _searchController = TextEditingController();
  ScrollController _cont = ScrollController();

  @override
  void initState() {
final _medProvider =
            Provider.of<MedicationProvider>(context, listen: false);

    _cont.addListener(() {
      if (_cont.position.maxScrollExtent == _cont.offset) {
        
            print(_medProvider.medicationsToView.length);
        if (_medProvider.reachedLast) {
          Toast.show("no more Medications", context);
        } else {
          _medProvider.search(_searchController.value.text);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final _medProvider = Provider.of<MedicationProvider>(context);
    final _favProvider = Provider.of<FavouritesProvider>(context);

 if(_medProvider.isFirst){
   _medProvider.search("");
 }


    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title:
            customBoldText(text: "Medications", color: Colors.black, size: 20),
        centerTitle: true,
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 40,
                width: Sizes.getWidth(275) * width,
                margin: EdgeInsets.only(left: Sizes.getWidth(16) * width),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      hintText: "search medications",
                      hintStyle: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 13,
                          color: Color.fromRGBO(36, 42, 55, .4)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          _medProvider
                              .search(_searchController.text,fromSearch: true);
                              
                        },
                      )),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1, color: Color(0xffEAE9E9))),
                margin: EdgeInsets.only(right: Sizes.getWidth(10) * width),
                child: InkWell(
                  onTap: () async {
                    print("filter");
                    if (_medProvider.keyWords.isEmpty) {
                    await _medProvider.search(_searchController.text);
                    }
                    showMedicationFilter(context);
                  },
                  child: CircleAvatar(
                    radius: Sizes.getWidth(25) * width,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/filter.png",
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: _medProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _medProvider.medicationsToView.isEmpty
                    ? Center(
                        child: Text("coudnt find your medication"),
                      )
                    : ListView.builder(
                        controller: _cont,
                        itemCount: _medProvider.medicationsToView.length,
                        itemBuilder: (con, index) {
                          return MedicationItem(
                              _medProvider.medicationsToView[index]);
                        },
                      ),
          )
        ],
      ),
    );
  }
}
