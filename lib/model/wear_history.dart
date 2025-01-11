import 'package:flutter/material.dart';

enum WearHistory {
  leastRecently,
  mostRecently;

  String get label {
    switch (this) {
      case WearHistory.leastRecently:
        return "Least Recently";
      case WearHistory.mostRecently:
        return "Most Recently";
    }
  }

  Icon get icon {
    switch (this) {
      case WearHistory.leastRecently:
        return Icon(Icons.access_time_rounded);
      case WearHistory.mostRecently:
        return Icon(Icons.access_time_filled_rounded);
    }
  }
}
