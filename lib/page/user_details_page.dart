import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/user_data.dart';
import 'package:ooo_fit/service/user_data_service.dart';
import 'package:ooo_fit/widget/auth/user_details_form.dart';
import 'package:ooo_fit/widget/common/form/edit_form_wrapper.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:ooo_fit/widget/common/page_formating/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_app_bar.dart';

class UserDetailsPage extends StatelessWidget {
  final UserDataService _userDataService = GetIt.instance<UserDataService>();

  UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'My details'),
        body: ContentFrameDetail(
          children: [
            LoadingFutureBuilder(
              future: _userDataService.getCurrentUsersData(),
              builder: (context, userData) {
                return EditFormWrapper(
                  onSaveSuccessMessage: "Your details were saved successfully",
                  onSave: handleSave,
                  child: UserDetailsForm(userData: userData!),
                );
              },
            ),
          ],
        ));
  }

  Future<String?> handleSave(Map<String, dynamic> formData) async {
    UserData? userData = await _userDataService.getCurrentUsersData();
    return await _userDataService.updateUserData(
      userData: userData!,
      city: formData['city'],
      name: formData['name'],
    );
  }
}
