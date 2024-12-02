import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';
import 'package:ooo_fit/widget/outfit_clothes/text_edit_label.dart';

class ClothesEditPage extends StatelessWidget {
  final String name = "Tie";
  final String placement = "Neck";
  final String style = "Formal";

  const ClothesEditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter name',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxWidth;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      // Grayscale picture
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: SizedPicture(
                        sizeX: size,
                        sizeY: size,
                        image: "assets/images/test_clothes.jpg",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Click to Change Picture"),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            TextEditLabel(label: "Placement"),
            SizedBox(height: 10),
            TextEditLabel(label: "Style"), // TODO Naseptavani?
            PageDivider(),
            LabelButton(
              label: "Create/Edit",
              backgroundColor: Colors.transparent,
              textColor: Colors.deepPurple,
            ),
            SizedBox(height: 20),
            LabelButton(
              label: "Delete",
              backgroundColor: Colors.transparent,
              textColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
