import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider with ChangeNotifier {
  List<Products> favourites = [];
  SharedPreferences _preferences;
  ApiHelper _helper = ApiHelper();
    bool isLoading=false;


  Future getFavourites() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    isLoading=true;
    notifyListeners();

    Map res = await _helper
        .getData(uri: "api/mobile/favourites?api_token=$token")
        .catchError((onError) {
          isLoading=false;
          notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading=false;
      notifyListeners();
      throw "no favourites added yet";
    }
    favourites.clear();
    List fav = res["data"][0];

    fav.forEach((f) {
      favourites.add(Products.fromJson(f));
    });
    isLoading=false;
    notifyListeners();
    //keyWords = _allMeds.keywords;
    
  }


  Future addtoFavourites(Products md)async{

      _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
            
          
    Map res = await _helper
        .postData(uri: "api/mobile/add_favourites",body: {
          "api_token":token,
          "product_id":md. id
        })
        .catchError((onError) {
      throw "network or server error";
    });
    if(favourites.contains(md)==false){
          favourites.add(md);
    }


  }






  Future removeFromFavourites(Products md)async{

      _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
            
           


    Map res = await _helper
        .postData(uri: "api/mobile/delete_favourites",body: {
          "api_token":token,
          "product_id":md. id
        })
        .catchError((onError) {
      throw "network or server error";
    });
    
     if(favourites.contains(md)){
          favourites.remove(md);
    }

notifyListeners();
  }





}





