import 'package:curey_user/providers/cart_provider.dart';
import 'package:curey_user/providers/orders_provider.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class CartHeader extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
            final cart=Provider.of<CartProvider>(context);
               final order=Provider.of<OrdersProvider>(context);
        var width=MediaQuery.of(context).size.width;

    return Container(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              customBoldText(
                  text: "Order Summary", size: 17, color: Color(0xff07A3A4)),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  customNormalText(
                      text: "Subtotal", color: Color(0xff474C56), size: 14),
                  customNormalText(
                      text: "\$${cart.subTotal.round()}", color: Color(0xff242A37), size: 14),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  customNormalText(
                      text: "Shipping Cost", color: Color(0xff474C56), size: 14),
                  customNormalText(
                      text: "\$${cart.shippingCost.round()}", color: Color(0xff242A37), size: 14),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  customBoldText(
                      text: "Total", color: Color(0xff474C56), size: 15),
                  customBoldText(
                      text: "\$${cart.total.round()}", color: Color(0xff242A37), size: 15),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: width * .7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff09CACB),
                    ),
                    child: Center(
                      child: customBoldText(
                          text: "Place Order", size: 14, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    print("place order");
                    showDialog(context: context,child: Dialog(

                      
                      child: Container(
                        width: MediaQuery.of(context).size.width*.7,
                        height: 200,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        
                        
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                           customBoldText(text:"Place Order",size:20,color: Color(0xff242A37)),
                          customNormalText(text:"Total is   \$${cart.total.round()}" ,size: 17),
                           InkWell(
                             onTap: ()async{
                               order.addOrder(cart.items).then((onValue){
                                cart.clear();
                                Navigator.of(context).pop();
                                
                               },onError: (_){
                                 Toast.show(_.toString(), context,duration: 10);
                                 Navigator.of(context).pop();
                                 
                               });
                             },
                          child: Container(
                             height: 35,
                             margin: EdgeInsets.symmetric(horizontal: 20),     
                            child: Center(
                      child: customBoldText(
                          text: "Confirm", size: 14, color: Colors.white),
                    ),
                             decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff09CACB),
                    ),

                          ),
                        )
                        ],
                      ),
                      ),
                      
                     
                      
                     

                    ));
                  },
                ),
              ),]),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 200;

  @override
  // TODO: implement minExtent
  double get minExtent => 175;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}