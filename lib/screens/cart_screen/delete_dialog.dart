import 'package:curey_user/models/cart_model.dart';
import 'package:curey_user/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class DeleteDialog extends StatefulWidget {
  CartItem item;
  DeleteDialog(this.item);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<CartProvider>(context);
    CartItem item = widget.item;

    return AlertDialog(
      title: Text(
        "Sure want to delete from cart",
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: isLoading
                ? null
                : () {
                    Navigator.of(context).pop();
                  },
            child:  Text("Cancel")),
        FlatButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });

                    await cartPro.removeFromCart(item).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      if (value == "s") {
                        Toast.show("item deleted ", context);
                        Navigator.of(context).pop();
                      } else {
                        Toast.show(value, context);
                        Navigator.of(context).pop();
                      }
                    });
                  },
            child:isLoading ? Center(child: CircularProgressIndicator()) : Text("Delete")),
      ],
    );
  }
}
