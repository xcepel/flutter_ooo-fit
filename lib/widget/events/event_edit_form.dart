import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/widget/common/form/delete_button.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/save_button.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/form/temperature_type_picker.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';

class EventEditForm extends StatelessWidget {
  final Event? event;
  final EventService _eventService = GetIt.instance.get<EventService>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  EventEditForm({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          NameFormField(
            value: event?.name,
          ),
          FormBuilderDateTimePicker(
            name: 'eventDatetime',
            decoration: InputDecoration(labelText: 'Date and time'),
            initialValue: event?.eventDatetime ?? DateTime.now(),
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            name: 'place',
            decoration: InputDecoration(labelText: 'Place'),
            initialValue: event?.place,
          ),
          SizedBox(height: 10),
          StylePicker(),
          SizedBox(height: 10),
          TemperatureTypePicker(),
          PageDivider(),
          SizedBox(height: 10),
          PageDivider(),
          SaveButton(onPressed: () => _handleSave(context)),
          SizedBox(height: 20),
          if (event != null)
            DeleteButton(onPressed: () => _handleDelete(context)),
        ],
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    String? error = await _eventService.deleteEvent(event: event!);

    //TODO: make into widget/util method
    if (context.mounted) {
      if (error == null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventsListPage(),
        ));
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error ?? "Event was deleted successfully"),
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }

  Future<void> _handleSave(BuildContext context) async {
    print(_formKey.currentState.toString());
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      String? error;
      if (event == null) {
        error = await _eventService.saveEvent(
          name: formData['name'],
          styleIds: formData['styleIds'],
          place: formData['place'],
          temperature: formData['temperature'],
          // TODO: create carousel for outfit selection
          outfitId: null,
          eventDatetime: formData['eventDatetime'],
        );
      } else {
        error = await _eventService.updateEvent(
          event: event!,
          name: formData['name'],
          styleIds: formData['styleIds'],
          place: formData['place'],
          temperature: formData['temperature'],
          outfitId: '',
          eventDatetime: formData['eventDatetime'],
        );
      }

      //TODO: make into widget/util method
      if (context.mounted) {
        if (error == null) {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error ?? "Event was saved successfully"),
          behavior: SnackBarBehavior.fixed,
        ));
      }
    } else {
      print("Validation failed");
    }
  }
}
