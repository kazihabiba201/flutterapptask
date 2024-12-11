import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/themes/app_style.dart';

import 'app_color.dart';

//ButtonStyle
ButtonStyle appButtonStyle(Color color,BorderRadius borderRadius, {Color? borderColor, }) {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: const EdgeInsets.all(0),
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
    ),
  );
}


//Ink
Ink successButtonChild(buttonText) {
  return Ink(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6), color: Pallets.colorBlue),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Pallets.colorWhite),
      ),
    ),
  );
}
