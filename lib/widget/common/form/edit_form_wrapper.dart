import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/utils/constants.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/round_button.dart';

class EditFormWrapper extends StatefulWidget {
  final Widget child;
  final String onSaveSuccessMessage;
  final String onDeleteSuccessMessage;
  final Future<String?> Function(Map<String, dynamic> formData) onSave;
  final Future<String?> Function()? onDelete;
  final Widget? onDeleteNavigationPage;

  const EditFormWrapper({
    super.key,
    required this.child,
    required this.onSaveSuccessMessage,
    required this.onDeleteSuccessMessage,
    required this.onSave,
    this.onDelete,
    required this.onDeleteNavigationPage,
  }) : assert(onDelete == null || onDeleteNavigationPage != null,
            'onDeleteNavigationPage must not be null if onDelete is provided');

  @override
  State<EditFormWrapper> createState() => _EditFormWrapperState();
}

class _EditFormWrapperState extends State<EditFormWrapper> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          widget.child,
          PageDivider(),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(),
            )
          else ...[
            RoundButton(
              icon: Icons.save_rounded,
              text: "Save",
              onPressed: () => _handleSave(),
            ),
            const SizedBox(height: 5),
            if (widget.onDelete != null)
              RoundButton(
                icon: Icons.delete_rounded,
                text: "Delete",
                onPressed: () => _handleDelete(),
                color: dangerRed,
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    final FormBuilderState? formState = _formKey.currentState;
    if (formState?.saveAndValidate() ?? false) {
      setState(() => isLoading = true);

      final Map<String, dynamic> formData = formState!.value;
      final String? error = await widget.onSave(formData);

      if (mounted) {
        setState(() => isLoading = false);
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: widget.onSaveSuccessMessage,
          onSuccessNavigation: () => Navigator.pop(context),
        );
      }
    }
  }

  Future<void> _handleDelete() async {
    setState(() => isLoading = true);

    final String? error = await widget.onDelete!();

    if (mounted) {
      setState(() => isLoading = false);
      handleActionResult(
        context: context,
        errorMessage: error,
        successMessage: widget.onDeleteSuccessMessage,
        onSuccessNavigation: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.onDeleteNavigationPage!,
            )),
      );
    }
  }
}
