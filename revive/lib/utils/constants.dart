import 'dart:ui';

import 'package:flutter/material.dart';

const kPrimary = Color(0xFFFF0202);
const kDark = Color(0xFF000000);
const kLight = Color(0xFFFFFFFF);
const kCard = Color(0xFFF08282);

const kDefaultPadding = 8.0;
const kHorizontalPadding = 32.0;
const kVerticalPadding = 16.0;

var whiteBoxDec = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(50),
    boxShadow: [
      BoxShadow(
          color: Colors.white.withOpacity(0.3),
          blurRadius: 5,
          spreadRadius: 2
      )
    ]
);

const gradientBoxDec = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  ),
  gradient: RadialGradient(
    center: Alignment(-0, 0.30),
    radius: 0.95,
    colors: [
      Color(0xFFFF7A7A),
      Color(0xFF101B44)
    ],
  ),
);