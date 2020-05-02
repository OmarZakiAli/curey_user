import 'package:curey_user/models/order_model.dart';
import 'package:curey_user/providers/orders_provider.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

buildOrderItem(BuildContext con, Orders order) {
          final _ord = Provider.of<OrdersProvider>(con, listen: true);

  var width = MediaQuery.of(con).size.width;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color:  Color(0x4D242A37).withOpacity(.2))
    ),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       Row(
         children: <Widget>[
           CircleAvatar(
             radius: 20,
             backgroundImage: AssetImage("assets/images/pharmacy_best.png"),
           ),
           SizedBox(width: 8,),
           Column(
             children: <Widget>[
               customBoldText(text: order.pharmacy,size: 14,color: Color(0xff474C56)),
               SizedBox(height: 10,),
               Row(
                 children: <Widget>[
                   Icon(Icons.location_on,size: 12,),
                   SizedBox(width: 2,),
                   customNormalText(
                     text: "Mansoura , jehan s",
                     size: 12,
                     color: Color(0xff7C7F87),
                   )
                 ],
               )
             ],
           ),
           Spacer(),
           customBoldText(
             text: "Delivered",
             size: 13,
             color: Color(0xffAEAEAE),
             weight: FontWeight.w600
           ),
         ],
       ),
       SizedBox(height: 8,)
       ,Divider(
         height: 2,
         color: Color(0xffAEAEAE),
       ),
       SizedBox(height: 8,),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
            customBoldText(text: "Order List",size: 12,color: Color(0xff242A37)),
            customBoldText(text: "\$${order.totalPrice.round()}",size: 14,color: Color(0xff242A37))
         ],
       ),
       ...order.products.map((pro){
         return Column(
           children: <Widget>[
             SizedBox(height: 12,),
            Row(
              children: <Widget>[

                customNormalText(text: pro.name,size: 12,color: Color(0xff474C56),max: 20),

              ],
            ),

           ],
         );
       }).toList(),
      
       SizedBox(height: 20,),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Container(
             height: 30,
             width: 90,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Color(0xff09CACB),
               
             ),
             child: Center(
               child: customBoldText(
                 text: "Trace Order"
                 ,color: Colors.white,
                 size: 13
                 
               ),
             ),
           ),
           InkWell(child:  Padding(
             padding: const EdgeInsets.only(top: 4,bottom: 4,left: 8),
             child: Center(
                 child: customBoldText(
                   text: "Cancel"
                   ,color: Colors.black38,
                   size: 13
                   
                 ),),

           ),
           onTap: ()async{
             _ord.cancelOrder(order.id.toString());
           },
           )
         ],
       )
     ],
   ),
  );
}
