import 'package:curey_user/models/med_details_model.dart';
import 'package:curey_user/models/medication_model.dart';

class CartItem {
  int id;
  String name;
  String price;
  int amount;
  String image;
  Pharmacy pharmacy;

  double get total{
   
   return double.parse(price)*amount;
    
  }
  CartItem(
      {this.id, this.name, this.price, this.amount, this.image, this.pharmacy});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
    image = json['image'];
    pharmacy = json['pharmacy'] != null
        ? new Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['image'] = this.image;
    if (this.pharmacy != null) {
      data['pharmacy'] = this.pharmacy.toJson();
    }
    return data;
  }
}

class Pharmacy {
  String name;
  String address;
  String image;
  int productPharmacyId;

  Pharmacy({this.name, this.address, this.image, this.productPharmacyId});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    image = json['image'];
    productPharmacyId = json['product_pharmacy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['product_pharmacy_id'] = this.productPharmacyId;
    return data;
  }
}

  








