import 'package:flutter/material.dart';
// import 'package:nectar_assets/ui/pages/alarms/alarms_details.dart';
import '../../../main.dart';
import 'package:firebase_config/firebase_config.dart';

class NotificationController {
  // ======================================================================================================
  // This method is used to initilize the awesome notification plugin and adding notification channels.
  // =====================================================================================================

  static const String alarmsChannelKey = 'alerts';

  static void awesomeNotificationinitialise() {
    AwesomeNotifications()
        .initialize(
      null,
      [
        NotificationChannel(
          channelKey: alarmsChannelKey,
          channelName: 'Alarms alerts',
          channelDescription: 'Alarms notifications',
          vibrationPattern: lowVibrationPattern,
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    )
        .onError((error, stackTrace) {
      print("error called");
      print(error);

      return true;
    });
  }

  // ======================================================================================================
  // Set listeners for Aweosme Notification

  static startListeningNotificationEvents() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }


 

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here

    // Map<String,dynamic> payload = receivedAction.payload!;

    // if (receivedAction.channelKey == alarmsChannelKey) {
    // });

    // print("onActionReceivedMethod Alarms Alert Channel key");

    // var alarmModel = AlarmNotifcationModel.fromJson(message!.data);

    print('===============================================================');
    print("onActionReceivedMethod Payload ${receivedAction.payload}");
    print(
        "========================================================================");

    Map<String, String?> data = receivedAction.payload!;

  //  NotificationController().loadSingletonPage(
  //     MyApp.navigatorKey.currentState,
  //     targetPage: AlarmsDetailsScreen.id,
  //     payload: {
  //       "eventId": data['eventId'],
  //       "name": data['name'],
  //       "sourceId": data['sourceId'],
  //       // "multiselectAsset": eventLog.
  //     },
  //   );
    // }

    print("=============================================================");
    print("CHANNEL KEY ${receivedAction.channelKey}");
    //  print("CHANNEL KEY ${receivedAction.dismissedDate}");
    print("onActionReceivedMethod ${receivedAction.body}");
    print(
        "=====================================================================");

    // Navigate into pages, avoiding to open the notification details page over another details page already opened

    // loadSingletonPage(
    //   MyApp.navigatorKey.currentState,
    //   targetPage: AlarmsListScreen.id,
    //   receivedAction: receivedAction,
    // );
  }

  void loadSingletonPage(
  NavigatorState? navigatorState, {
  required String targetPage,
  Map<String, String?>? payload,
}) {
  // Avoid to open the notification details page over another details page already opened
  // Navigate into pages, avoiding to open the notification details page over another details page already opened

  // print(navigatorState == null);

  navigatorState?.pushNamed(
    targetPage,
    arguments: payload,
  );
}
}


