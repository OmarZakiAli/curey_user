import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/appointments_model.dart';
import 'package:curey_user/models/available_times_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsProvider with ChangeNotifier{


 ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
   List<AppointmentsModel> appointments=[];
    bool isFirst=true;
    bool isLoading=false;






Future getAllAppointments()async{
          isLoading=true;
          notifyListeners();
   _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    Map res=await _helper.getData(uri:"api/mobile/appointments?api_token=$token").catchError((x){
                            print(x.toString());
                            isLoading=false;
                            
                            notifyListeners();
                            throw "network or server error";
                                                   
    });

     if(res["isFailed"]){
       isLoading=false;
       notifyListeners();
       throw "no appointments yet";
     }

     appointments.clear();
    List badList=res["data"];
    badList.forEach((f){
      appointments.add(AppointmentsModel.fromJson(f));
    });

    isFirst=false;
    isLoading=false;
    notifyListeners();
     
}

Future addAppointment({int id,bool isCallUp, String time})async{
  isLoading=true;
  notifyListeners();

 _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
            
          
    Map res = await _helper
        .postData(uri: "api/mobile/book_appointment",body: {
          "api_token":token,
          "doctor_id": id,
          "appointment_time":time,
          "is_callup":isCallUp
        })
        .catchError((onError) {
          isLoading=false;
          notifyListeners();
      throw "network or server error";
    });

if(res["isFailed"]){
  isLoading=false;
  notifyListeners();
  throw "cant add appointment";
}

   isLoading=false;
   notifyListeners();
    getAllAppointments(); 

}






}