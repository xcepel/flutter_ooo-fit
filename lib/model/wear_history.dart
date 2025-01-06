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

  IconData get picture {
    switch (this) {
      case WearHistory.leastRecently:
        return Icons.access_time_rounded;
      case WearHistory.mostRecently:
        return Icons.access_time_filled_rounded;
    }
  }
}
