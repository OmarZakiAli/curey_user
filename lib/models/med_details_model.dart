class MedicationDetailModel {
  Product product;
  List<Pharmacies> pharmacies;

  MedicationDetailModel({this.product, this.pharmacies});

  MedicationDetailModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['pharmacies'] != null) {
      pharmacies = new List<Pharmacies>();
      json['pharmacies'].forEach((v) {
        pharmacies.add(new Pharmacies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.pharmacies != null) {
      data['pharmacies'] = this.pharmacies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String id;
  String name;
  String image;
  String description;
  String price;
  String deliveryFees;
  String userAddress;
  bool isFavourite;

  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.price,
      this.deliveryFees,
      this.userAddress,
      this.isFavourite});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    deliveryFees = json['delivery_fees'];
    userAddress = json['user_address'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['delivery_fees'] = this.deliveryFees;
    data['user_address'] = this.userAddress;
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}

class Pharmacies {
  String name;
  String address;
  String image;
  double overallRating;
  int productPharmacyId;

  Pharmacies(
      {this.name,
      this.address,
      this.image,
      this.overallRating,
      this.productPharmacyId});

  Pharmacies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    image = json['image'];
    overallRating = json['overall_rating']+0.0;
    productPharmacyId = json['product_pharmacy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['overall_rating'] = this.overallRating;
    data['product_pharmacy_id'] = this.productPharmacyId;
    return data;
  }
}
