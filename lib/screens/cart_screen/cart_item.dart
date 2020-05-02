import 'package:curey_user/models/cart_model.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/cart_provider.dart';
import 'package:curey_user/screens/cart_screen/delete_dialog.dart';
import 'package:curey_user/screens/medication_details_screen/medication_details_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  CartItemWidget(this.cartItem);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<CartProvider>(context);

    CartItem item = this.widget.cartItem;
    var width = MediaQuery.of(context).size.width;

    return Dismissible(
      secondaryBackground: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            size: 20.0,
          ),
        ),
      ),
      background: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.edit,
            size: 20.0,
          ),
        ),
      ),
      key: ValueKey(item.pharmacy.productPharmacyId),
      confirmDismiss: (dir) async {
        if (DismissDirection.endToStart == dir) {
          return showDialog(
              context: context,
              builder: (con) {
                return DeleteDialog(item);
              });
        } else if (DismissDirection.startToEnd == dir) {
          return showModalBottomSheet(
              context: context,
              builder: (_) {
                return AddingToCartBottomSheet(item);
              });
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (con) {
                  return MedicationDetailsScreen(pro: Products(id:item.id));
                }));
              },
              child: Image.asset(
                "assets/images/asprin.png",
                width: Sizes.getWidth(100) * width,
                height: 80,
              ),
            ),
            Container(
              color: Color(0xffAEAEAE),
              width: .5,
              height: 80,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (con) {
                              return MedicationDetailsScreen(pro: Products(id:item.id));
                            }));
                          },
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 10,
                                child: Center(
                                  child: customBoldText(
                                      text: item.amount.toString(), size: 10),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              customBoldText(
                                  max: 20,
                                  text: item.name,
                                  size: 14,
                                  color: Color(0xff07A3A4)),
                            ],
                          ),
                        ),
                        customBoldText(
                            text: "\$${item.total}",
                            size: 14,
                            color: Color(0xff242A37)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Color(0xffAEAEAE),
                      width: width,
                      height: .5,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage("assets/images/pharmacy_best.png"),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: Sizes.getWidth(90) * width,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: customNormalText(
                                        text: item.pharmacy.name,
                                        size: 10,
                                        color: Color(0xff474C56)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 9,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: Sizes.getWidth(80) * width,
                                      child: customNormalText(
                                          maxlines: 2,
                                          max: 30,
                                          text: item.pharmacy.address,
                                          size: 9),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddingToCartBottomSheet extends StatefulWidget {
  final CartItem item;
  AddingToCartBottomSheet(this.item);
  @override
  _AddingToCartBottomSheetState createState() =>
      _AddingToCartBottomSheetState();
}

class _AddingToCartBottomSheetState extends State<AddingToCartBottomSheet> {
  int itemCount = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartItem item = widget.item;
    final cartPro = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 170,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    if (itemCount == 0) {
                      Navigator.of(context).pop();
                      Toast.show("cant be zero", context);
                    } else {
                      cartPro.editCartItem(item, itemCount).then((value) {
                        if (value == "s") {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                          Toast.show(value, context);
                        }
                      });
                    }
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
