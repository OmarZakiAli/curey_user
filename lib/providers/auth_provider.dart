import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/city_model.dart';
import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/models/sign_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  UserSignUpModel _user = UserSignUpModel();
  LocalizationModel local = LocalizationModel();

  List<CityModel> cities = [];

  setUsername(String name) {
    _user.userName = name;
  }

  setUserEmail(String email) {
    _user.email = email;
  }

  setUserPassword(String password) {
    _user.password = password;
  }

  setUserCity(int city) {
    _user.city = city;
  }

  Future<String> signUserUp() async {
    print(_user.city);
    String toReturn;
    Map res;
    await _helper.postData(uri: "api/mobile/signup", body: _user.toJson()).then(
        (value) {
      res = value;
      if (res["isFailed"] == true) {
        toReturn = "email already exists";
      } else {
        toReturn = "success";
      }
    }, onError: (e) {
      toReturn = "network or server problem";
    });

    return toReturn;
  }

  Future<String> signUserIn() async {
    _preferences = await SharedPreferences.getInstance();
    String toReturn;
    Map res;
    await _helper.postData(uri: "api/mobile/userLogin", body: {
      "user": _user.email,
      "password": _user.password,
    }).then((_) async {
      res = _;
      if (res["isFailed"]) {
        toReturn = "wrong email or password";
      } else {
        _preferences.setString("token", res["data"]["api_token"]);
        toReturn = "Succees";
      }
    }, onError: (e) {
      print(e.toString());
      toReturn = "network error";
    });

    return toReturn;
  }

  Future init(String lang) async {
    Map res = await _helper.getData(uri: "api/mobile/signup");
    print(res["data"]["cities"][1]["name"]);

    List _ci = res["data"]["cities"];
    _ci.forEach((f) {
      cities.add(CityModel.fromJson(f));
    });

    Map res2 = await _helper.getData(uri: "api/mobile/locale/$lang/1");
    local = LocalizationModel.fromJson(res2["data"]["local"]);
    print(local.skip);
  }

  Future logOut() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    Map res = await _helper.postData(uri: "api/mobile/logout", body: {
      "api_token": token,
    }).catchError((e) {
      throw e.toString();
    });

    if (res["isFailed"] == false) {
      _preferences.remove("token");
    } else {
      throw "wrong email ";
    }
  }
}
