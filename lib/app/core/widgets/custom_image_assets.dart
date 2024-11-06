import 'package:flutter/material.dart';

Widget customImageAssets({
  required String imagePath,
  double height = 140,
  BoxFit fit = BoxFit.fill,
}) {
  return Image.asset(
    imagePath,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return Image.asset(
        imagePath,
        fit: fit,
      );
    },
  );
}
