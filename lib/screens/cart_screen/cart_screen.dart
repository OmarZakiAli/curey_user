import 'package:curey_user/providers/cart_provider.dart';
import 'package:curey_user/screens/cart_screen/cart_header.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_item.dart';
import 'package:curey_user/providers/orders_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
        final cart=Provider.of<CartProvider>(context,listen: false);
        if(cart.isFirst){
          cart.getCartItems();
        }

  }
  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<CartProvider>(context);
    //final order=Provider.of<OrdersProvider>(context);

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: customBoldText(
            text: "Shopping Cart", color: Colors.black, size: 20),
        centerTitle: true,
        leading:IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
          Navigator.of(context).pop();
        }),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff09CACB),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:cart.isLoading? Center(
          child: CircularProgressIndicator(),
        ) :cart.items.isEmpty?Center(child:Text("Cart is Empty")) :CustomScrollView(
          slivers: <Widget>[
           SliverPersistentHeader(
                 delegate: CartHeader(),
                 floating: false,
                 pinned: false,

           ),
           SliverList(
            
             delegate: SliverChildBuilderDelegate(
              
               (con,index){
             return CartItemWidget(cart.items[index]);

             },
             childCount: cart.items.length
             ),

           ),
           
          ],
        ),
      ),
    );
  }
}
