class SubmetOrder {
  String apiToken;
  List<CartProduct> cartProducts;

  SubmetOrder({this.apiToken, this.cartProducts});

  SubmetOrder.fromJson(Map<String, dynamic> json) {
    apiToken = json['api_token'];
    if (json['products'] != null) {
      cartProducts = new List<CartProduct>();
      json['products'].forEach((v) {
        cartProducts.add(new CartProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_token'] = this.apiToken;
    if (this.cartProducts != null) {
      data['products'] = this.cartProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProduct {
  String id;
  String amount;

  CartProduct({this.id, this.amount});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    return data;
  }
}
