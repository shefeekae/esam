import 'package:app_filter_form/widgets/passwords/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/user_auth_helpers.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static const String id = 'profile/password/change';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: ChangePasswordForm(
        isMobile: true,
        successHandler: () {
          UserAuthHelpers().logOut(context);
        },
      ),
    );
  }
}
