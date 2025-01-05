import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ooo_fit/model/outfit.dart';

class ImagePicker extends StatelessWidget {
  const ImagePicker({
    super.key,
    this.value,
    required this.isRequired,
  });

  final String? value;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: 'image',
      maxImages: 1,
      decoration: InputDecoration(labelText: 'Photo'),
      initialValue: [value],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        print(value);
        if (isRequired) {
          if (value == null || value.isEmpty || value[0] == null) {
            return 'Photo is required, pick one';
          }
        }
        return null;
      },
    );
  }
}
