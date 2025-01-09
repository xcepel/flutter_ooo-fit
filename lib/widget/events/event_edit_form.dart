import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/common/form/carousel.dart';
import 'package:ooo_fit/widget/common/form/carousel_form_field.dart';
import 'package:ooo_fit/widget/common/form/delete_button.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/save_button.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/form/temperature_type_picker.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';

class EventEditForm extends StatefulWidget {
  final Event? event;
  final EventService _eventService = GetIt.instance.get<EventService>();

  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  EventEditForm({
    super.key,
    this.event,
  });

  @override
  State<EventEditForm> createState() => _EventEditFormState();
}

class _EventEditFormState extends State<EventEditForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _hideOutfitCarousel = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
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
          FormBuilderCheckbox(
            name: 'showOutfitCarousel',
            title: Text('I do not want to select an outfit now.'),
            onChanged: (value) => setState(() {
              _hideOutfitCarousel = value ?? true;
            }),
          ),
          if (!_hideOutfitCarousel) _buildCarouselFormField(),
          SaveButton(onPressed: () => _handleSave(context)),
          SizedBox(height: 20),
          if (widget.event != null)
            DeleteButton(onPressed: () => _handleDelete(context)),
        ],
      ),
    );
  }

  Widget _buildCarouselFormField() {
    return LoadingStreamBuilder(
      stream: widget._outfitService.getAllOutfitsStream(),
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

  Future<void> _handleDelete(BuildContext context) async {
    String? error =
        await widget._eventService.deleteEvent(event: widget.event!);

    if (context.mounted) {
      handleActionResult(
        context: context,
        errorMessage: error,
        successMessage: "Event was deleted successfully",
        onSuccessNavigation: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventsListPage(),
          ));
        },
      );
    }
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      String? error;
      if (widget.event == null) {
        error = await widget._eventService.saveEvent(
          name: formData['name'],
          styleIds: formData['styleIds'],
          place: formData['place'],
          temperature: formData['temperature'],
          outfitId: _hideOutfitCarousel ? null : formData['outfitId'][0],
          eventDatetime: formData['datetime'],
        );
      } else {
        error = await widget._eventService.updateEvent(
          event: widget.event!,
          name: formData['name'],
          styleIds: formData['styleIds'],
          place: formData['place'],
          temperature: formData['temperature'],
          outfitId: _hideOutfitCarousel ? null : formData['outfitId'][0],
          eventDatetime: formData['datetime'],
        );
      }

      if (context.mounted) {
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: "Event was saved successfully",
          onSuccessNavigation: () => Navigator.pop(context),
        );
      }
    }
  }
}
