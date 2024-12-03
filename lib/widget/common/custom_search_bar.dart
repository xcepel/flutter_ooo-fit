import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final bool whiteStyle;

  const CustomSearchBar({super.key, this.whiteStyle = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(
          color: whiteStyle ? Colors.white : Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: whiteStyle ? Colors.white : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: whiteStyle ? Colors.white : Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: whiteStyle ? Colors.white : Colors.black,
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: whiteStyle ? Colors.white : Colors.black,
        ),
      ),
      style: TextStyle(
        color: whiteStyle ? Colors.white : Colors.black,
      ),
    );
  }
}
