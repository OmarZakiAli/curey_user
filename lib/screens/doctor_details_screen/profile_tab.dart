import 'package:curey_user/models/doctor_detail_model.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final DoctorDetailModel _doctorDetailModel;
  ProfileTab(this._doctorDetailModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
      children: <Widget>[
        customBoldText(text: "Biography",size: 14,color: Color(0xff242A37),textAlign: TextAlign.left),
        SizedBox(height: 10,),
        customLongText(_doctorDetailModel.doctor.qualifications),
        SizedBox(height: 20,),
        customBoldText(text: "Degress",size: 14,color: Color(0xff242A37),textAlign: TextAlign.left),
        SizedBox(height: 10,),
         _doctorDetailModel.doctor.degrees.length==0?customNormalText(text:"none"):
         _doctorDetailModel.doctor.degrees.map((f){
           return Column(
             children: <Widget>[
               SizedBox(height: 8,),
               customNormalText(text:f,color: Color(0xff242A37),size: 14,max: 35,textAlign: TextAlign.left )
             ],
           );
         }).toList()
       
        ,SizedBox(height: 20,),
        customBoldText(text: "Contact Info",size: 14,color: Color(0xff242A37),textAlign: TextAlign.left),
        SizedBox(height: 10,),

        customNormalText(textAlign: TextAlign.left,text: "mobile : ${_doctorDetailModel.doctor.mobile}" ),
        SizedBox(height: 4,),
        customNormalText(textAlign: TextAlign.left,text: "email : ${_doctorDetailModel.doctor.email}" ),

          SizedBox(height: 24,)
        
      ],
      ),
    );
  }
}

customLongText(String text){
  return customNormalText(
    color: Color(0xff7C7F87),
    size: 16,
    text: text,
    maxlines: 50,
    textAlign: TextAlign.left,
    max: 400
  );
}