import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';
      bool validate=false;

Widget signUpFormField(BuildContext context,
    {String text,
    String hint,
    bool secure,
    bool isPhone = false,
    Function validator,
    TextEditingController cont,
    }) {


  return Container(
    padding: EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: customBoldText(text: text, size: 12, weight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: cont,
          onChanged: (s){
            print(s);
            if(s.isEmpty ){
              validate=false;
              print(validate);
            }else{
              validate=true;
              print(validate);
            }
          },
          
          maxLength: 50,
          autovalidate:validate? true:false,
          validator:  validator,
          keyboardType:
              isPhone ? TextInputType.phone : TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 20, left: 12),
            hintText: hint,
            fillColor: Color(0xffFBFBFB),
            focusColor: Color(0xffFBFBFB),
            hoverColor: Color(0xffFBFBFB),
            hintStyle: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 13,
                color: Color.fromRGBO(36, 42, 55, .4)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          obscureText: secure,
        ),
      ],
    ),
  );
}
