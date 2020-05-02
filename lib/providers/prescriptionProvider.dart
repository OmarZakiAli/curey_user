import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/adding_prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:curey_user/models/prescription_model.dart';
import 'package:curey_user/helpers/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionProvider with ChangeNotifier {
  List<PrescriptionModel> prescriptions = [];
  bool isLoading = false;
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
   bool isFirst=true;


  Future showPrescriptions() async {
    isLoading = true;
    notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    Map res = await _helper
        .getData(uri: "api/mobile/prescriptions?api_token=$token")
        .catchError((x) {
      print(x.toString());
      isLoading = false;

      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      notifyListeners();
      throw "no prescriptions added yet";
    }

    prescriptions.clear();
    List badList = res["data"];
    badList.forEach((f) {
      prescriptions.add(PrescriptionModel.fromJson(f));
    });
    isFirst=false;
    isLoading = false;
    notifyListeners();
  }



  Future addPrescription(AddingPrescriptionModel add) async {

     isLoading=true;
     notifyListeners();
      DateTime t=DateTime.now().add(Duration(days: 300));
      add.endDate="${t.year}-${t.month}-${t.day}";

      if(add.frequency==null){
        isLoading=false;
        throw "add frequency please";
            
      }else if(add.medicineName==null||add.medicineName==""){
        isLoading=false;
        throw "add medication name please";
      }else if(add.hours.isEmpty){
                isLoading=false;
        throw "enter at least one dosage time";
      }

    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    add.apiToken = token;
    Map res = await _helper
        .postData(uri: "api/mobile/add_prescription", body: add.toJson())
        .catchError((x) {
      print(x.toString());
      isLoading=false;
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading=false;
      notifyListeners();
       throw "error adding discription";
    }
            isLoading=false;
            
      int x=res["data"]["prescription_id"];
      print(x);
      notifyListeners();
      showPrescriptions();
    return x;
  }



  Future removePrescription(PrescriptionModel pre)async{
       NotificationHelper _help=NotificationHelper();

      _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
            
           


    Map res = await _helper
        .postData(uri: "api/mobile/delete_prescription",body: {
          "api_token":token,
          "prescription_id": pre.id
        })
        .catchError((onError) {
          print(onError.toString());
      throw "network or server error";
    });
    
     if(prescriptions.contains(pre)){
          prescriptions.remove(pre);
    }
       _help.deleteNoti(pre.id);
       showPrescriptions();
notifyListeners();
  }


  
}
