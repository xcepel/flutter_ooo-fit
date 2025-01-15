import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/common/round_button.dart';

class WearNowButton extends StatelessWidget {
  final String outfitId;

  final EventService _eventService = GetIt.instance.get<EventService>();

  WearNowButton({
    super.key,
    required this.outfitId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoundButton(
        icon: Icons.accessibility_rounded,
        text: "Wear now",
        onPressed: () => _wearOutfitToday(context),
      ),
    );
  }

  void _wearOutfitToday(BuildContext context) async {
    String? error = await _eventService.wearOutfitNow(outfitId: outfitId);

    if (context.mounted) {
      handleActionResult(
          context: context,
          errorMessage: error,
          successMessage:
              'This outfit was successfully saved to your calendar.');
    }
  }
}
