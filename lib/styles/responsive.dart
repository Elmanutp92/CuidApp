import 'dart:math';

import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get diagonal => sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight));
}