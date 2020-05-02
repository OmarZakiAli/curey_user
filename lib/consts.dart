import 'package:flutter/material.dart';

 class Sizes{

static getHeight(double h){
  return h/812;
}


static getWidth(double w){
  return w/375;
}

}

class CureyColors {
   static getPrimary() {
     return Color.fromRGBO(64, 164, 163, 1);
}
}