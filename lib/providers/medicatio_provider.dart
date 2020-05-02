import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationProvider with ChangeNotifier {
  MedicationModel allMeds = MedicationModel(products: [], keywords: []);
  List<Products> medicationsToView = [];
  List<Keywords> keyWords = [];
  bool isLoading = false;
  SharedPreferences _preferences;
  ApiHelper _helper = ApiHelper();
  List<Products> favourites = [];
  List<Keywords> _filter = [];
  bool reachedLast = false;
  String _currentSearch = "";
  bool isFirst = true;
  int currentOp = 0;

   search(String word, {bool fromSearch = false}) {
    if (word != _currentSearch || fromSearch) {
      allMeds.products = [];
      medicationsToView = [];
      reachedLast = false;
    }

    _currentSearch = word;
    if (_currentSearch.isEmpty) {
      getAllMeds();
    } else {
      searchMeds(word);
    }
  }

  Future getAllMeds() async {
    if (allMeds.products.isEmpty) {
      isLoading = true;
      notifyListeners();
    }
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    Map res = await _helper
        .getData(
            uri:
                "api/mobile/medications?api_token=$token&skip=${allMeds.products.length}&limit=15")
        .catchError((onError) {
      print(onError.toString());
      isLoading = false;
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      notifyListeners();
      throw "didn't find your medication";
    }

    List<Products> toAdd = MedicationModel.fromJson(res["data"]).products;
    if (toAdd.length < 15) {
      reachedLast = true;
    }
    allMeds.products.addAll(toAdd);
    await sortBy(currentOp);

    //print(res["data"]);
    medicationsToView = allMeds.products;
    keyWords.length == 0
        ? keyWords = MedicationModel.fromJson(res["data"]).keywords
        : keyWords;
    print(keyWords.length);
    isLoading = false;
    isFirst = false;
    notifyListeners();
  }

  Future searchMeds(String med) async {
    if (allMeds.products.isEmpty) {
      isLoading = true;
      notifyListeners();
    }

    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    Map res = await _helper
        .getData(
            uri:
                "api/mobile/medications/search?name=$med&api_token=$token&skip=${allMeds.products.length}&limit=15${_filter.isEmpty ? "" : "${_filter.map((k) {
                    return "&keywords[${_filter.indexOf(k)}]=${k.id}";
                  })}"}".replaceAll(")", "").replaceAll("(", ""))
        .catchError((onError) {
      isLoading = false;
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      notifyListeners();
      throw "didn't find your medication";
    }
    List<Products> toAdd = MedicationModel.fromJson(res["data"]).products;
    if (toAdd.length < 15) {
      reachedLast = true;
    }
    allMeds.products.addAll(toAdd);
    await sortBy(currentOp);

    medicationsToView = allMeds.products;
    keyWords.length == 0
        ? keyWords = MedicationModel.fromJson(res["data"]).keywords
        : keyWords;
    print(res["data"]);
    //keyWords = _allMeds.keywords;
    isLoading = false;
    isFirst = false;
    notifyListeners();
  }

  Future filterbyKeyword(List<Keywords> keys, int op) async {
    isLoading = true;
    notifyListeners();
    _filter = keys;
    currentOp = op;
    await sortBy(op);

    if (keys.isNotEmpty) {
      medicationsToView = allMeds.products.where((test) {
        bool contains = false;
        keys.forEach((k) {
          if (test.keywords.contains(k.id)) {
            contains = true;
          }
        });
        return contains;
      }).toList();
    } else {
      medicationsToView = allMeds.products;
    }

    isLoading = false;
    notifyListeners();
  }

  Future sortBy(int op) {
    if (op == 0) {
      print("object");

      allMeds.products.sort((p1, p2) {
        return double.parse(p1.price).compareTo(double.parse(p2.price));
      });
    } else {
      allMeds.products.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    }
  }
}
