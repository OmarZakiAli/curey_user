import 'package:curey_user/screens/add_prescription_screen/add_prescription_screen.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curey_user/providers/prescriptionProvider.dart';
import 'prescreption_item.dart';

class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {

  @override
  void initState() {
    final _presc=Provider.of<PrescriptionProvider>(context,listen: false);
    
    if( _presc.isFirst){
      _presc.showPrescriptions();
    }
    
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
   final _presc=Provider.of<PrescriptionProvider>(context,listen: true);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        
        tooltip: "add new prescription",
        elevation: 8,
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (s) {
            return AddPrescriptionScreen();
          }));
        },
      ),
      key: _scaffoldKey,
      drawer: buildAppDrawer(),
      appBar: AppBar(
        title: customBoldText(
            text: "Prescriptions", color: Colors.black, size: 20),
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
      body: Container(
        padding: EdgeInsets.only(right: 16, left: 16, top: 20),
        child: _presc.isLoading?Center(child:CircularProgressIndicator()):
        _presc.prescriptions.isEmpty?Center(child:customNormalText(
          text: "No prescriptions added yet"
        )):
         ListView.builder(
          itemCount: _presc.prescriptions.length,
          itemBuilder: (con, index) {
            return buildPrescriptionItem(con, _presc.prescriptions[index]);
          },
        ),
      ),
    );
  }
}
