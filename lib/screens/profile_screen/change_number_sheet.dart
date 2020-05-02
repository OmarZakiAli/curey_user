import 'package:curey_user/screens/sign_up_screen/sign_up_field.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';

class ChangePhoneSheet extends StatefulWidget {
  @override
  _ChangePhoneSheetState createState() => _ChangePhoneSheetState();
}

class _ChangePhoneSheetState extends State<ChangePhoneSheet> {
  TextEditingController _phoneCont = TextEditingController();
  bool isValid = false;
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          customBoldText(text: "Phone Number"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: customBoldText(
                    text: "Phone", size: 12, weight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _phoneCont,
                onChanged: (s) {
                  print(s);
                  if (s.isEmpty) {
                    validate = false;
                    print(validate);
                  } else {
                    validate = true;
                    print(validate);
                  }
                },
                maxLength: 50,
                autovalidate: validate,
                validator: (s) {
                  if (s.length != 11) {
                    isValid = false;

                    return "write valid number";
                  }
                  setState(() {
                                      isValid = true;

                  });
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20, left: 12),
                  hintText: "01xxxxxxxxx",
                  fillColor: Color(0xffFBFBFB),
                  focusColor: Color(0xffFBFBFB),
                  hoverColor: Color(0xffFBFBFB),
                  hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                      fontSize: 13,
                      color: Color.fromRGBO(36, 42, 55, .4)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                obscureText: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: customBoldText(text: "Cancel"),
                onTap: () {
                  print("cancel");
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: customBoldText(text: "Submit"),
                onTap: !isValid
                    ? null
                    : () {
                        print("submit");
                        Navigator.of(context).pop();
                      },
              ),
            ],
          )
        ],
      ),
    );
  }
}
