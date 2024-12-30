enum PiecePlacement {
  body,
  top,
  bottom,
  feet,
  head,
  hands,
  neck,
  waist,
  other;

  String get label {
    switch (this) {
      case PiecePlacement.head:
        return "Head";
      case PiecePlacement.neck:
        return "Neck";
      case PiecePlacement.body:
        return "Body";
      case PiecePlacement.top:
        return "Top";
      case PiecePlacement.waist:
        return "Waist";
      case PiecePlacement.bottom:
        return "Bottom";
      case PiecePlacement.feet:
        return "Feet";
      case PiecePlacement.hands:
        return "Hands";
      case PiecePlacement.other:
        return "Other";
    }
  }

  String get picture {
    switch (this) {
      case PiecePlacement.head:
        return "assets/icons/placements/head.png";
      case PiecePlacement.neck:
        return "assets/icons/placements/neck.png";
      case PiecePlacement.body:
        return "assets/icons/placements/body.png";
      case PiecePlacement.top:
        return "assets/icons/placements/top.png";
      case PiecePlacement.waist:
        return "assets/icons/placements/waist.png";
      case PiecePlacement.bottom:
        return "assets/icons/placements/bottom.png";
      case PiecePlacement.feet:
        return "assets/icons/placements/feet.png";
      case PiecePlacement.hands:
        return "assets/icons/placements/hands.png";
      case PiecePlacement.other:
        return "assets/icons/placements/other.png";
    }
  }
}
