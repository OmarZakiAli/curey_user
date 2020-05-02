import 'package:curey_user/helpers/api_helper.dart';
import 'package:curey_user/models/cart_model.dart';
import 'package:curey_user/models/order_model.dart';
import 'package:curey_user/models/submet_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersProvider with ChangeNotifier {
  bool isLoading = false;
  ApiHelper _helper = ApiHelper();
  SharedPreferences _preferences;
  SubmetOrder _submetOrder = SubmetOrder();
  OrderModel order = OrderModel();
  bool isFirst = true;

  Future addOrder(List<CartItem> items) async {
    _submetOrder.cartProducts = [];
    isLoading = true;
    notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    _submetOrder.apiToken = token;
    items.forEach((item) {
      _submetOrder.cartProducts.add(CartProduct(
          id: item.pharmacy.productPharmacyId.toString(),
          amount: item.amount.toString()));
    });

    Map res = await _helper
        .postData(uri: "api/mobile/submit_order", body: _submetOrder.toJson())
        .catchError((onError) {
      print(onError.toString());
      isLoading = false;
      notifyListeners();
      throw "network or server error";
    });

    if (res["isFailed"]) {
      isLoading = false;
      notifyListeners();
      throw "error submetting order";
    }
    isLoading = false;
     
    notifyListeners();
    getAllOrders();
  }

  Future getAllOrders() async {
    order.orders = [];

    isLoading = true;
    notifyListeners();

    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");

    Map res = await _helper
        .getData(
      uri: "api/mobile/orders?api_token=$token",
    )
        .catchError((onError) {
      print(onError.toString());
      isLoading = false;
      notifyListeners();
      throw "network or server error";
    });
    print(res["data"]);

    if (res["isFailed"]) {
      isLoading = false;
      notifyListeners();
      throw "no orders yet";
    }
    order = OrderModel.fromJson(res["data"]);
    isLoading = false;
    isFirst = false;
    notifyListeners();
  }

  cancelOrder(String id) async {
    isLoading=true;
    notifyListeners();
    _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    await _helper
        .postData(uri: "api/mobile/cancel_order",body: {
          "api_token":token,
          "order_id":id
        })
        .then((onValue) {
          if(onValue["isFailed"]){
            isLoading=false;
            notifyListeners();
            throw "cant cancel this order";
            
          }else{
            getAllOrders();
          }
        },onError: (e){
          isLoading=false;
            notifyListeners();
          throw "network error";

        });
  }
}
