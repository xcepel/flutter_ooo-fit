import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class WearNowButton extends StatelessWidget {
  final String outfitId;

  final EventService _eventService = GetIt.instance.get<EventService>();

  WearNowButton({
    super.key,
    required this.outfitId,
  });

  @override
  Widget build(BuildContext context) {
    return LabelButton(
      label: "I'm wearing this now",
      backgroundColor: Colors.transparent,
      textColor: Colors.grey,
      onPressed: () => _wearOutfitToday(context),
    );
  }

  void _wearOutfitToday(BuildContext context) async {
    String? error = await _eventService.wearOutfitNow(outfitId: outfitId);

    if (context.mounted) {
      handleActionResult(
          context: context,
          errorMessage: error,
          successMessage:
              'This outfit was successfully saved to you calendar.');
    }
  }
}
