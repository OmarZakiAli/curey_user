import 'package:flutter/material.dart';

showWarning(BuildContext context,String title,String hint){

    showDialog(
            context: context,
            builder: (con) {
              return AlertDialog(
                title: Text(title),
                content: Text(
                    hint),
              );
            });
}