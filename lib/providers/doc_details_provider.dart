import 'dart:collection';

import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/available_times_model.dart';
import 'package:curey_user/models/doctor_detail_model.dart';
import 'package:curey_user/models/med_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetailsProvider with ChangeNotifier {
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  DoctorDetailModel doc;
   HashMap _cache= HashMap<String,DoctorDetailModel>();

  AvailableTimes times=AvailableTimes(firstDay: FirstDay(available: []),secondDay:FirstDay(available: []));
  int cid = -1;

  Future<DoctorDetailModel> getDoctDetails(int id) async {
      
   if(_cache.containsKey(id.toString())){
     return _cache[id.toString()];
   }
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
      
    Map res = await _helper
        .getData(uri: "/api/mobile/doctor?api_token=$token&id=${id.toString()}")
        .catchError((onError) {
      print(onError.toString());
      print("failed server");
      throw "network or server error";
    });

    if (res["isFailed"]) {
      print("failed");
      throw "error retrieving data";
    }

    print(res["data"]);

    doc = DoctorDetailModel.fromJson(res["data"]);
    _cache[id.toString()]=doc;
     print(" model error");
     getAvailableTimes(id);
     print("non model error");
    getAvailableTimes(id);
    return doc;
  }

  Future getAvailableTimes(int id) async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
          
       times.firstDay.available=[];
       times.secondDay.available=[];
       
    Map res = await _helper
        .getData(uri: "api/mobile/book_appointment?api_token=$token&doctor_id=$id")
        .catchError((x) {
      print(x.toString());

      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      throw "no free times";
    }

    times = AvailableTimes.fromJson(res["data"]);
    print(res["data"]);
    print(times.firstDay.available.length);
    notifyListeners();

  }
}
