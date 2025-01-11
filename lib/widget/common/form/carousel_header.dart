import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/constants.dart';

class CarouselHeader extends StatelessWidget {
  final Widget? leading;
  final bool multipleSelection;
  final VoidCallback onAddCarousel;
  final VoidCallback onRemoveCarousel;

  final double buttonSize = 20.0;

  const CarouselHeader({
    super.key,
    this.leading,
    required this.multipleSelection,
    required this.onAddCarousel,
    required this.onRemoveCarousel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(detailLightPurple),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  leading != null ? leading! : const SizedBox(),
                  const Spacer(),
                  if (multipleSelection) _buildAddRemoveButtons(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Row _buildAddRemoveButtons() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline_rounded,
            color: Colors.black,
            size: buttonSize,
          ),
          onPressed: onAddCarousel,
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.black,
            size: buttonSize,
          ),
          onPressed: onRemoveCarousel,
        ),
      ],
    );
  }
}
