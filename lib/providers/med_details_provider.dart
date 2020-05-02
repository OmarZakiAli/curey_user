import 'dart:collection';

import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/med_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationDetailsProvider with ChangeNotifier {
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  int cid=-1;
  MedicationDetailModel medicationDetailModel ;
 HashMap _cache= HashMap<String,MedicationDetailModel>();


  Future<MedicationDetailModel> getProductDetails(int id) async {
   
   if(_cache.containsKey(id.toString())){
     return _cache[id.toString()];
   }


    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    

    Map res = await _helper
        .getData(uri: "api/mobile/medication?api_token=$token&id=$id")
        .catchError((onError) {
          print(onError.toString());
      print("failed");
      throw "network or server error";
    });

    if (res["isFailed"]) {
      print("failed");
      throw "error retrieving data";
    }

   // medicationDetailModel = MedicationDetailModel.fromJson(res["data"]);
    print(res["data"]);
     medicationDetailModel= MedicationDetailModel.fromJson(res["data"]);
     _cache[medicationDetailModel.product.id]=medicationDetailModel;
    return medicationDetailModel;
  }
}
