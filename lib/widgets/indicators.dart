import "package:flutter/material.dart";
import "../globalVars.dart" as globals;

Widget Indicators({required int size, required int active}) {
  List<Widget> indicators = [];
  for (int i = 0; i < size; i++) {
    indicators.add(Indicator(isCurrent: (i == active) ? true : false));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: indicators,
  );
}

Widget Indicator({required bool isCurrent}) {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isCurrent ? globals.primary : Colors.grey,
    ),
  );
}
