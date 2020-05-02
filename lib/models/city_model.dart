class CityModel {
  int id;
  String name;
  int deliveryFees;
  Null createdAt;
  Null updatedAt;

  CityModel(
      {this.id, this.name, this.deliveryFees, this.createdAt, this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliveryFees = json['delivery_fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delivery_fees'] = this.deliveryFees;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
