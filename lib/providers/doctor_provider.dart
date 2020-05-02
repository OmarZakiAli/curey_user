import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/city_model.dart';
import 'package:curey_user/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsProvider with ChangeNotifier {
  DoctorModel _allDoctors = DoctorModel(doctors: []);
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  List<Doctors> doctorsToView = [];
  List<Specialities> specs = [];
  bool isLoading = false;
  bool isFirst = true;
  bool reachedLast = false;
  int currentCity = -1;
  int currentSpec = -1;
  int sortOption = 0;
  String _currentSearch = "";

  search(String word,{bool fromSearch=false}) {
    if (word != _currentSearch||fromSearch) {
      _allDoctors.doctors = [];
      doctorsToView = [];
      reachedLast = false;
    }

    _currentSearch = word;
    if (_currentSearch.isEmpty) {
      getAllDoctors();
    } else {
      searchDoctors(word);
    }
  }

  Future<void> getAllDoctors() async {
    if (_allDoctors.doctors.isEmpty) {
      isLoading = true;
      notifyListeners();
    }

    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    print(currentCity);
    print(currentSpec);
    Map res = await _helper
        .getData(
            uri:
                "api/mobile/doctors?api_token=$token&skip=${_allDoctors.doctors.length}&limit=15")
        .catchError((onError) {
      isLoading = false;
      print("failed server");
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      print("failed");
      notifyListeners();
      throw "didn't find doctor's you need";
    }

    List<Doctors> toAdd = DoctorModel.fromJson(res["data"]).doctors;
    if (toAdd.length < 15) {
      reachedLast = true;
    }
    _allDoctors.doctors.addAll(toAdd);
    print(res["data"]["doctors"]);
    doctorsToView = _allDoctors.doctors;
       specs.isEmpty? specs = DoctorModel.fromJson(res["data"]).specialities:specs;
    isLoading = false;
    isFirst = false;
    sortBy(sortOption);
    notifyListeners();
  }

  Future filterbyCityandSpec({int cityId, Specialities spec, int op}) async {
    isLoading = true;
    await sortBy(op);
    currentCity = cityId;
    currentSpec = spec.id;
    notifyListeners();
    if (cityId == -1 && spec.name != "All Spesialities") {
      filterbySpec(spec);
      return;
    } else if (cityId != -1 && spec.name == "All Spesialities") {
      filterbyCity(cityId);
      return;
    } else if (cityId == -1 && spec.name == "All Spesialities") {
      doctorsToView = _allDoctors.doctors;
      isLoading = false;
      notifyListeners();
      return;
    }
    doctorsToView = _allDoctors.doctors.where((test) {
      if (test.cityId == cityId && test.speciality == spec.name) {
        return true;
      } else {
        return false;
      }
    }).toList();
    isLoading = false;
    notifyListeners();
  }

  Future sortBy(int op) {
    sortOption=op;
    if (op == 0) {
      print("object");

      _allDoctors.doctors.sort((d1, d2) {
        return double.parse(d1.fees).compareTo(double.parse(d2.fees));
      });
    } else {
      _allDoctors.doctors.sort((a, b) {
        return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
      });
    }
  }

  Future filterbyCity(int cityId) async {
    isLoading = true;
    notifyListeners();

    doctorsToView = _allDoctors.doctors.where((test) {
      if (test.cityId == cityId) {
        return true;
      } else {
        return false;
      }
    }).toList();
    isLoading = false;
    notifyListeners();
  }

  Future filterbySpec(Specialities spec) async {
    isLoading = true;
    notifyListeners();

    doctorsToView = _allDoctors.doctors.where((test) {
      if (test.speciality == spec.name) {
        return true;
      } else {
        return false;
      }
    }).toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> searchDoctors(String doc) async {
    if (_allDoctors.doctors.isEmpty) {
      isLoading = true;
      notifyListeners();
    }

    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    print(currentSpec);
    print(currentCity);
    Map res = await _helper
        .getData(
            uri:
                "api/mobile/doctors/search?name=$doc&api_token=$token&skip=${_allDoctors.doctors.length}&limit=15&city_id=${currentCity == -1 ? "" : currentCity}&speciality_id=${currentSpec == -1 ? "" : currentSpec}")
        .catchError((onError) {
      isLoading = false;
      print("failed");
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      print("failed");
      notifyListeners();
      throw "didn't find doctor with this name";
    }

    List<Doctors> toAdd = DoctorModel.fromJson(res["data"]).doctors;
    if (toAdd.length < 15) {
      reachedLast = true;
    }
    _allDoctors.doctors.addAll(toAdd);
    print(res["data"]["doctors"]);
    doctorsToView = _allDoctors.doctors;
       specs.isEmpty? specs = DoctorModel.fromJson(res["data"]).specialities:specs;
    isLoading = false;
    sortBy(sortOption);

    notifyListeners();
  }
}
