import 'package:flutter/material.dart';
import 'package:graphql_config/services/user_auth_services.dart';
import 'package:nectar_assets/core/services/notifications/notification_services.dart';
import 'package:nectar_assets/ui/pages/login/login_screen.dart';

class UserAuthHelpers {
  logOut(BuildContext context) {
    // SharedPrefrencesServices.removeRemindMe();

    NotificationServiceHelper()
        .firebaseMessagingSubcribeOrUnsubcribeTopic(subcribe: false);

    UserAuthServices().logOut();

    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
  }
}
