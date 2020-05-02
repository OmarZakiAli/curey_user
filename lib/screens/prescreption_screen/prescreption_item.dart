
import 'package:curey_user/providers/prescriptionProvider.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:curey_user/models/prescription_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

buildPrescriptionItem(BuildContext context, PrescriptionModel pres) {
      final _presc=Provider.of<PrescriptionProvider>(context,listen: false);
      
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color:Color(0x5D5D5D4D)),
    ),
    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
    margin: EdgeInsets.symmetric(vertical:6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            customBoldText(
              text: pres.medicine,
              color: Color(0xff07A3A4),
              size: 16,
              max: 32,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _presc.removePrescription(pres).then((onValue){},onError: (e){
                  Toast.show(e.toString(), context);
                });
              },
              
            ),
          ],
        ),
        customBoldText(text: "Frequency"),
        SizedBox(height:6),

        customNormalText(text: "${pres.frequency} times per day",size: 12,color: Color(0xff474C56)),
         SizedBox(height:10),

        customBoldText(text: "Dosing Times",size: 14,color: Colors.black),
        SizedBox(height:6),
        ...pres.dosageTime.map((f){
          return Column(
            children: <Widget>[
              SizedBox(height: 3,),
              customNormalText(text:f,max: 10),
            ],
          );
        }).toList(),
        SizedBox(height: 10,),
         customBoldText(text: "Days",size: 14,color: Colors.black),
        SizedBox(height:6),
        ...pres.days.map((f){
          return Column(
            children: <Widget>[
              SizedBox(height: 3,),
              customNormalText(text:f,max: 10),
            ],
          );
        }).toList(),
        
      ],
    ),
  );
}
