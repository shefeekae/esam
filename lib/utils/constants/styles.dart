import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';

var linearGradientPrimaryTheme = LinearGradient(
  colors: gradientColors,
  begin: Alignment.center,
  end: Alignment.bottomCenter,
);

BoxDecoration homeCardDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(25),
  gradient: linearGradientPrimaryTheme,
);
