import 'package:flutter/material.dart';
import 'package:flutterapptask/app/core/constants/app_constants.dart';

import 'app_color.dart';

//InputDecoration
InputDecoration appInputDecoration(String label,
    {bool suffixIcon = true,
    String? prefixText,
    String? hintText,
    bool isObscured = true,
    VoidCallback? toggleObscure}) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Pallets.colorBlue, width: 1),
    ),
    fillColor: Pallets.colorWhite,
    filled: true,
    prefixText: prefixText,
    suffixIcon: suffixIcon
        ? IconButton(
            icon: Icon(
              isObscured ? Icons.visibility_off : Icons.visibility,
              color: Pallets.colorDarkBlue,
            ),
            onPressed: toggleObscure,
          )
        : null,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Pallets.colorBlue, width: 0),
    ),
    border: const OutlineInputBorder(),
    hintText: hintText,
    labelText: label,
    labelStyle: const TextStyle(color: Pallets.colorDarkBlue),
  );
}

//BoxDecoration
BoxDecoration boxDecoration(
    {Color? borderColor, double? borderRadius, Color? bgColor}) {
  return BoxDecoration(
    border: Border.all(color: borderColor ?? Colors.grey),
    borderRadius: BorderRadius.circular(borderRadius ?? 0),
    color: bgColor,
  );
}

// ==== SHAPE AND BORDER RADIUS ====
const borderradiusCheckBox =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)));
const borderRadiusShape = RoundedRectangleBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(AppConstants.borderRadiusPoint)));
const shapeVerticalTop = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.borderRadiusPoint)));
const shapeVerticalBottom = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(AppConstants.borderRadiusPoint)));
const borderRadius =
    BorderRadius.all(Radius.circular(AppConstants.borderRadiusPoint));
const chipBorderRadius = borderRadius;
const cardBorderRadius = borderRadius;
const textFieldborderRadiusPoint = AppConstants.borderRadiusPoint;
final checkboxShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
const roundedRectangleBorder =
    RoundedRectangleBorder(borderRadius: borderRadius);
const bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(40)));
