import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/widget/common/form/carousel.dart';
import 'package:ooo_fit/widget/common/form/carousel_form_field.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/form/temperature_type_picker.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';

class EventEditForm extends StatefulWidget {
  final Event? event;

  const EventEditForm({
    super.key,
    this.event,
  });

  @override
  State<EventEditForm> createState() => _EventEditFormState();
}

class _EventEditFormState extends State<EventEditForm> {
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();
  late bool _hideOutfitCarousel;

  @override
  void initState() {
    super.initState();
    _hideOutfitCarousel =
        widget.event == null ? false : widget.event?.outfitId == null;
  }

  @override
  void didUpdateWidget(covariant EventEditForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.event != oldWidget.event) {
      setState(() {
        _hideOutfitCarousel =
            widget.event == null ? false : widget.event?.outfitId == null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameFormField(
          value: widget.event?.name,
          isRequired: false,
        ),
        FormBuilderDateTimePicker(
          name: 'datetime',
          decoration: InputDecoration(labelText: 'Date and time'),
          initialValue: widget.event?.eventDatetime ?? DateTime.now(),
          validator: FormBuilderValidators.required(),
        ),
        SizedBox(height: 10),
        FormBuilderTextField(
          name: 'place',
          decoration: InputDecoration(labelText: 'Place'),
          initialValue: widget.event?.place,
        ),
        SizedBox(height: 10),
        StylePicker(
          selectedStyles: widget.event?.styleIds,
        ),
        SizedBox(height: 10),
        TemperatureTypePicker(
          selectedTemperatureType: widget.event?.temperature,
        ),
        _buildHideOutfitCarouselCheckbox(),
        if (!_hideOutfitCarousel) _buildCarouselFormField(),
      ],
    );
  }

  FormBuilderCheckbox _buildHideOutfitCarouselCheckbox() {
    return FormBuilderCheckbox(
      name: 'hideOutfitCarousel',
      title: Text('I do not want to select an outfit now.'),
      onChanged: (value) => setState(() {
        _hideOutfitCarousel = value ?? true;
      }),
      initialValue: _hideOutfitCarousel,
    );
  }

  Widget _buildCarouselFormField() {
    return LoadingStreamBuilder(
      stream: _outfitService.getAllNonArchivedStream(),
      builder: (context, outfits) {
        String? outfitId = widget.event?.outfitId;
        return CarouselFormField(
          items: outfits
              .map((Outfit outfit) => CarouselItem(
                    id: outfit.id,
                    child: OutfitListItem(outfit: outfit),
                  ))
              .toList(),
          selectedIds: outfitId != null ? [outfitId] : null,
          multipleSelection: false,
          name: 'outfitId',
          leading: Text('Outfit'),
          forEventOutfit: true,
        );
      },
    );
  }
}
