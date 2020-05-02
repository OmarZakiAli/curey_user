import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/cart_model.dart';
import 'package:curey_user/models/med_details_model.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> items = [];
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  bool isLoading = false;
  bool isFirst=true;

  double get subTotal {
    double subtot = 0.0;
    items.forEach((item) {
      subtot += item.total;
    });
    return subtot;
  }

  clear() {
      getCartItems();    
    notifyListeners();
  }

  double get shippingCost {
    return 20.0;
  }

  double get total {
    return shippingCost + subTotal;
  }

  Future getCartItems() async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    isLoading = true;
    notifyListeners();
    await _helper.getData(uri: "/api/mobile/cart?api_token=$token").then((res) {
      if (res["isFailed"]) {
        isLoading = false;
        notifyListeners();
        throw "error getting data";
      } else {
        List raw = res["data"];

        items = raw.map((f) {
          return CartItem.fromJson(f);
        }).toList();
        isLoading = false;
        isFirst=false;
        notifyListeners();
      }
    }, onError: (e) {
      isLoading = false;
      notifyListeners();
      throw "network error";
    });
  }

  Future<String> addToCart({Products pro, int count, Pharmacies pharm}) async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    String toReturn;

    await _helper.postData(uri: "api/mobile/add_item", body: {
      "api_token": token,
      "product": {"id": pharm.productPharmacyId, "amount": count}
    }).then((onValue) {
      if (onValue["isFailed"]) {
        toReturn = "error adding item";
      } else {
         getCartItems();
        toReturn = "s";
      }
    }, onError: (e) {
      toReturn = "network error";
    });

    return toReturn;
  }

  contains(Pharmacies pharm) {
    bool isThere = false;

    items.forEach((item) {
      if (pharm.productPharmacyId == item.pharmacy.productPharmacyId) {
        isThere = true;
      }
    });
    return isThere;
  }

  Future removeFromCart(CartItem item) async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    String toReturn;

    await _helper.postData(uri: "api/mobile/delete_item", body: {
      "api_token": token,
      "product_id": item.pharmacy.productPharmacyId
    }).then((onValue) {
      if (onValue["isFailed"]) {
        toReturn = "error deleting item";
      } else {
      getCartItems();
        print(items.length);
        toReturn = "s";
      }
    }, onError: (e) {
      toReturn = "network error";
    });
    notifyListeners();
    return toReturn;
  }

  Future editCartItem(CartItem item, int count) async {
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    String toReturn;

    await _helper.postData(uri: "api/mobile/update_item", body: {
      "api_token": token,
      "product": {"id": item.pharmacy.productPharmacyId, "amount": count}
    }).then((onValue) {
      if (onValue["isFailed"]) {
        toReturn = "error editing item";
      } else {
       getCartItems();
        toReturn = "s";
      }
    }, onError: (e) {
      toReturn = "network error";
    });
    notifyListeners();
    return toReturn;
  }
}
