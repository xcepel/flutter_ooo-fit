import 'package:flutter/material.dart';

enum TemperatureType {
  cold,
  chilly,
  warm,
  hot;

  /// Determines the [TemperatureType] based on a given temperature in Celsius.
  static TemperatureType fromCelsius(double celsius) {
    if (celsius < 10) {
      return TemperatureType.cold;
    } else if (celsius < 18) {
      return TemperatureType.chilly;
    } else if (celsius < 26) {
      return TemperatureType.warm;
    } else {
      return TemperatureType.hot;
    }
  }

  String get label {
    switch (this) {
      case TemperatureType.cold:
        return "Cold";
      case TemperatureType.chilly:
        return "Chilly";
      case TemperatureType.warm:
        return "Warm";
      case TemperatureType.hot:
        return "Hot";
    }
  }

  static const IconData iconValue = Icons.thermostat_rounded;

  Icon get icon {
    switch (this) {
      case TemperatureType.cold:
        return Icon(iconValue, color: Colors.lightBlue);
      case TemperatureType.chilly:
        return Icon(iconValue, color: Colors.blueGrey);
      case TemperatureType.warm:
        return Icon(iconValue, color: Colors.orangeAccent);
      case TemperatureType.hot:
        return Icon(iconValue, color: Colors.redAccent);
    }
  }
}
