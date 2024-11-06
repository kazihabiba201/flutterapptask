import 'package:flutter/material.dart';

import 'app_color.dart';

//ButtonStyle
ButtonStyle appButtonStyle(color) {
  return ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.all(0),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)));
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
