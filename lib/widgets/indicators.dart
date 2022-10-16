import "package:flutter/material.dart";
import "../globalVars.dart" as globals;

/// Renders the required number of [Indicator] widgets in a [Row]
/// 
/// It takes 2 named arguments [size] and [active], both integers.
/// [size] refers to the number of [Indicator] instances to be loaded inside the [Row] wrapper. 
/// [active] indicates the currently active [Indicator] to provide emphasis upon.
Widget Indicators({required int size, required int active}) {
  // The list corresponds to the children [Indicator] elements supplied to the [Row] wrapper.
  List<Widget> indicators = [];
  for (int i = 0; i < size; i++) {
    indicators.add(Indicator(isCurrent: (i == active) ? true : false));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: indicators,
  );
}

/// Supplies the individual [Indicator] needed by the [Indicators] widget.
/// 
/// It takes 1 named argument: [isCurrent]. 
/// If [isCurrent] is set to [true], different styles are applied to indicate active element.
/// If [isCurrent] is set to [false], it is served with normal styles. 
Widget Indicator({required bool isCurrent}) {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      // [globals.primary] refers to the primary color of the application theme.
      color: isCurrent ? globals.primary : Colors.grey,
    ),
  );
}
