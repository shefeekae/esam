import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  static const String id = 'profile/update';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: FormWidget(
        isMobile: true,
        formType: FormType.profileUpdate,
        apiCallNeeded: false,
        editPayload: {
          'user': arguments['initialPayload'],
        },
        initialValues: arguments['initialValues'],
        isEdit: false,
        saveSuccessHandler: (data) {
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}
