import 'package:curey_user/dialogs/doctors_filter.dart';
import 'package:curey_user/screens/doctors_screen/doctor_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curey_user/dialogs/warning_dialog.dart';
import 'package:toast/toast.dart';
import '../../consts.dart';
import 'package:curey_user/providers/doctor_provider.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final _searchController = TextEditingController();
  ScrollController _cont = ScrollController();

  @override
  void initState() {
    _cont.addListener(() {
      if (_cont.position.maxScrollExtent == _cont.offset) {
        final _docProvider =
            Provider.of<DoctorsProvider>(context, listen: false);

        if (_docProvider.reachedLast) {
          Toast.show("no more doctors", context);
        } else {
          _docProvider.search(_searchController.value.text);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _docProvider = Provider.of<DoctorsProvider>(context);
    if (_docProvider.isFirst) {
      _docProvider.search("");
    }
    print(_docProvider.doctorsToView.length);

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: customBoldText(text: "Doctors", color: Colors.black, size: 20),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
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
                      hintText: "search doctor",
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
                        onPressed: () {
                          _docProvider
                              .search(_searchController.text, fromSearch: true);
                              
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
                    if (_docProvider.specs.isEmpty) {
                      await _docProvider.search(_searchController.text);
                    }
                    showDoctorFilter(context);
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
            child: _docProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _docProvider.doctorsToView.isEmpty
                    ? Center(
                        child: Text("coudnt find your doctor"),
                      )
                    : ListView.builder(
                        controller: _cont,
                        itemCount: _docProvider.doctorsToView.length,
                        itemBuilder: (con, index) {
                          return buildDoctorItem(
                              con, _docProvider.doctorsToView[index]);
                        },
                      ),
          )
        ],
      ),
    );
  }
}
