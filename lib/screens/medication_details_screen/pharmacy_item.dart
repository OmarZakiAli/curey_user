import 'package:curey_user/models/cart_model.dart';
import 'package:curey_user/models/med_details_model.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/cart_provider.dart';
import 'package:curey_user/providers/orders_provider.dart';
import 'package:curey_user/screens/cart_screen/cart_screen.dart';
import 'package:curey_user/screens/home_screen/home_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class PharmacyItem extends StatefulWidget {
  final Pharmacies pharm;
  final Products pro;
  PharmacyItem({Key key, this.pharm, this.pro}) : super(key: key);
  @override
  _PharmacyItemState createState() => _PharmacyItemState();
}

class _PharmacyItemState extends State<PharmacyItem> {
  bool isEnabled = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Pharmacies pharm = widget.pharm;
    Products pro = widget.pro;

    final cart = Provider.of<CartProvider>(context, listen: true);
    final order = Provider.of<OrdersProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.symmetric(vertical: 4),
            color: Color(0xffF9FBFC),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * .25,
                  child: Image.asset(
                    "assets/images/asprin.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    customBoldText(
                        text: pharm.name, size: 14, color: Color(0xff07A3A4)),
                    SizedBox(
                      height: 4,
                    ),
                    SmoothStarRating(
                      borderColor: Colors.yellow,
                      color: Colors.yellow,
                      allowHalfRating: true,
                      starCount: 5,
                      rating: 3.5 - .1,
                      size: 15,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    customNormalText(
                      text: "100 reviews",
                      size: 10,
                      color: Color(0xffAEAEAE),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        customNormalText(
                            text: pharm.address,
                            size: 11,
                            color: Color(0xff474C56)),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: width * .6,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: !isEnabled
                                  ? null
                                  : () async {
                                      setState(() {
                                        isEnabled = false;
                                      });
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return AddingToCartBottomSheet();
                                          }).then((value) {
                                        if (value == 0) {
                                          Toast.show("item count cant be zero",
                                              context);
                                          setState(() {
                                            isEnabled = true;
                                          });
                                        } else if (value == null) {
                                          return;
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          order.addOrder([
                                            CartItem(
                                                id: pro.id,
                                                name: pro.name,
                                                amount: value,
                                                price: pro.price,
                                                pharmacy: Pharmacy(
                                                  name: pharm.name,
                                                  address: pharm.address,
                                                  productPharmacyId:
                                                      pharm.productPharmacyId,
                                                  image: pharm.image,
                                                ))
                                          ]).then((_) {
                                            Toast.show(
                                                "item ordered successfully",
                                                context);
                                            setState(() {
                                              isEnabled = true;
                                              isLoading = false;
                                            });
                                          }, onError: (_) {
                                            Toast.show("error submetting order",
                                                context);
                                            setState(() {
                                              isEnabled = true;
                                            });
                                          });
                                        }
                                      });
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff09CACB),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 35,
                                width: Sizes.getWidth(80) * width,
                                child: Center(
                                  child: customBoldText(
                                    text: "Order",
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Sizes.getWidth(30) * width,
                          ),
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: cart.contains(pharm)
                                  ? () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => CartScreen()));
                                    }
                                  : () async {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return AddingToCartBottomSheet();
                                          }).then((value) async {
                                        if (value == 0) {
                                          Toast.show("item count cant be zero",
                                              context);
                                        } else if (value == null) {
                                          return;
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await cart
                                              .addToCart(
                                            pro: pro,
                                            pharm: pharm,
                                            count: value,
                                          )
                                              .then((value) {
                                            print(value);
                                            setState(() {
                                              isLoading = false;
                                              isEnabled = true;
                                            });
                                            if (value == "s") {
                                              Toast.show(
                                                  "added successfuly", context);
                                            } else {
                                              Toast.show(
                                                  value.toString(), context);
                                            }
                                          });
                                        }
                                      });
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xff09CACB), width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 35,
                                child: Center(
                                  child: customBoldText(
                                    text: cart.contains(pharm)
                                        ? "Go to Cart"
                                        : "Add to Cart",
                                    size: 14,
                                    color: Color(0xff09CACB),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}

class AddingToCartBottomSheet extends StatefulWidget {
  @override
  _AddingToCartBottomSheetState createState() =>
      _AddingToCartBottomSheetState();
}

class _AddingToCartBottomSheetState extends State<AddingToCartBottomSheet> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: customBoldText(text: "Item Count", size: 18)),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      itemCount > 0 ? itemCount-- : itemCount;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xffF3F4F8),
                    radius: 20,
                    child: Center(
                        child: Icon(
                      Icons.minimize,
                      size: 12,
                      color: Colors.black,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: customBoldText(
                      text: itemCount.toString(),
                      size: 20,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (itemCount < 30) {
                        itemCount++;
                      }
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xffF3F4F8),
                    radius: 20,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: 14,
                      color: Colors.black,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(itemCount);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff09CACB), width: 1),
                  borderRadius: BorderRadius.circular(20)),
              height: 30,
              width: MediaQuery.of(context).size.width * .6,
              child: Center(
                child: customBoldText(
                  text: "Submit",
                  size: 14,
                  color: Color(0xff09CACB),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
