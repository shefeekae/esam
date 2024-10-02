// import 'package:hive/hive.dart';
// import 'package:roster_app/core/models/local%20db/notify%20me/notify_me_model.dart';
// import '../shared_prefrence_service.dart';
// import '../sharedprefrence_services.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:aweso';

import 'package:firebase_config/services/firebase_messaging.dart';
import 'package:secure_storage/model/user_data_model.dart';

class NotificationServiceHelper {
  // Box<NotifyMeDb> box = Hive.box(NotifyMeDb.boxName);

  UserDataSingleton userData = UserDataSingleton();

//   static void showLocalNotification(
//     RemoteMessage message,
//     String channelKey, {
//     NotificationCalendar? notificationCalendar,
//     Map<String, String?>? payload,
//   }) {
//     RemoteNotification? remoteNotification = message.notification;
//     AndroidNotification? androidNotification = message.notification?.android;

//     if (remoteNotification != null && androidNotification != null) {
//       print(message.data);
//       // scheduleNotifyNotification(message.data);

//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: remoteNotification.hashCode,
//           channelKey: channelKey,
//           title: remoteNotification.title,
//           body: remoteNotification.body,
//           category: NotificationCategory.Status,
//           // actionType: ActionType.KeepOnTop,
//           fullScreenIntent: false,
//           payload: payload,
//         ),
//         schedule: notificationCalendar,
//       );
//     } else {
//       print("null value called");
//     }
//   }

//   // void scheduleLocalNotification({
//   //   required String identifier,
//   //   required String title,
//   //   required String body,
//   //   required String parentIdentifier,
//   //   required NotificationCalendar notificationCalendar,
//   // }) {
//   //   try {
//   //     AwesomeNotifications().createNotification(
//   //       content: NotificationContent(
//   //         id: identifier.hashCode,
//   //         channelKey: "alarms-alert",
//   //         title: title,
//   //         body: body,
//   //         category: NotificationCategory.Reminder,
//   //         locked: true,
//   //         fullScreenIntent: true,
//   //         payload: {
//   //           "identifier": identifier,
//   //           "rosterIdentifier": parentIdentifier,
//   //         },
//   //       ),
//   //       schedule: notificationCalendar,
//   //     );
//   //   } catch (e) {
//   //     print('schedule notification function catch bloc called');
//   //     print(e);
//   //   }
//   // }

//   // // ==================================================================================================================================================
//   // // This method is used to initialise the flutter local notification and control the user's clicking notification and redirect to a specific page.
//   // // ============================================ Flutter Local Notification Handling =================================================================

//   static void setListeners(BuildContext context) {
//     try {
//       AwesomeNotifications().setListeners(
//         onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//         onDismissActionReceivedMethod:
//             NotificationController.onDismissActionReceivedMethod,
//         onNotificationDisplayedMethod:
//             NotificationController.onNotificationDisplayedMethod,
//       );
//     } catch (e) {
//       print("setListeners catch_bloc called");
//       print(e);
//     }
//   }

//   // ==================================================================================================================================
//   // This method is used when the user clicks the notification and is redirected to a specific page.
//   // ===========================Firebase Cloud Messaging Background notification handling ===========================================

//   static void firebaseBackgroundNotificationClickableHandling(
//       BuildContext context) {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       RemoteNotification? remoteNotification = message.notification;
//       AndroidNotification? androidNotification = message.notification?.android;

//       if (remoteNotification != null && androidNotification != null) {
//         var alarmModel = AlarmNotifcationModel.fromJson(message.data);

//         print(
//             "======================PAYLOD ===========================================");
//         print(
//           {
//             "eventId": alarmModel.eventId,
//             "name": alarmModel.name,
//             "sourceId": alarmModel.sourceId,
//             // "multiselectAsset": eventLog.
//           },
//         );

//         loadSingletonPage(
//           MyApp.navigatorKey.currentState,
//           targetPage: AlarmsDetailsScreen.id,
//           payload: {
//             "eventId": alarmModel.eventId,
//             "name": alarmModel.name,
//             "sourceId": alarmModel.sourceId,
//           },
//         );

//         print("foreground onMessageOPenedApp called ${message.data}");
//       }
//     });
//   }

//   // ==============================================================================================================================================
//   // This method is used when the app is terminated and the user clicks the notification to redirect to a specific page. (Terminated app means the app is closed from recent apps).
//   // ========================Firebase Cloud Messaging Terminated app notification handling ========================================================

//   static void firebaseAppTerminatedNotificationClickableHandling(
//       BuildContext context) {
//     print("firebaseAppTerminatedNotificationClickableHandling called");

//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       RemoteNotification? remoteNotification = message?.notification;
//       AndroidNotification? androidNotification = message?.notification?.android;

//       if (remoteNotification != null && androidNotification != null) {
//         print(message?.data);
//         print('--------------------------------------------------');
//         Future.delayed(const Duration(seconds: 1), () {
//           // Navigator.of(context).pushNamed(JobDetailsScreen.id, arguments: {
//           //   "title": message!.data['title'],
//           // });

//           var alarmModel = AlarmNotifcationModel.fromJson(message!.data);

//           print(
//               "======================PAYLOD ===========================================");
//           print(
//             {
//               "eventId": alarmModel.eventId,
//               "name": alarmModel.name,
//               "sourceId": alarmModel.sourceId,
//               // "multiselectAsset": eventLog.
//             },
//           );

//           loadSingletonPage(
//             MyApp.navigatorKey.currentState,
//             targetPage: AlarmsDetailsScreen.id,
//             payload: {
//               "eventId": alarmModel.eventId,
//               "name": alarmModel.name,
//               "sourceId": alarmModel.sourceId,
//             },
//           );
//         });
//       }
//     });
//   }

//   // ============================================================================================================================================
//   // This method is used to handle the backround message from FCM and scheduling a alert notification to user.
//   // ============================================================================================================================================

//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     // If you're going to use other Firebase services in the background, such as Firestore,
//     // make sure you call `initializeApp` before using other Firebase services
//     print("firebaseMessagingBackgroundHandler called");

//     try {
//       await Firebase.initializeApp();
//       // NotificationService().showLocalNotification(message, "job_alert");

//       RemoteNotification? remoteNotification = message.notification;
//       AndroidNotification? androidNotification = message.notification?.android;

//       if (remoteNotification != null && androidNotification != null) {
//         // NotificationService().showLocalNotification(RemoteMessage());
//         print(message.data);
//         print('--------------------------------------------------');

//         var alarmModel = AlarmNotifcationModel.fromJson(message.data);

//         print(
//             "======================PAYLOD ===========================================");
//         print(
//           {
//             "eventId": alarmModel.eventId,
//             "name": alarmModel.name,
//             "sourceId": alarmModel.sourceId,
//             // "multiselectAsset": eventLog.
//           },
//         );

//         showLocalNotification(
//           message,
//           NotificationController.alarmsChannelKey,
//           payload: {
//             "eventId": alarmModel.eventId,
//             "name": alarmModel.name,
//             "sourceId": alarmModel.sourceId,
//             // "multiselectAsset": eventLog.
//           },
//         );
//       } else {
//         print("REMOTE NOTIFICATION VALUE CALLED");
//       }

//       // print(DateTime.fromMillisecondsSinceEpoch())
//     } on FirebaseException catch (e) {
//       print("firebase catch bloc called");
//       print(e.message);
//     } catch (e) {
//       print("catch bloc called");
//       print(e);
//     }
//   }

//   // ============================================================================================
//   // Firebase foreground message handler.

//   void firebaseMessageForegroundHandler() {
//     try {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         RemoteNotification? remoteNotification = message.notification;
//         AndroidNotification? androidNotification =
//             message.notification?.android;

//         if (remoteNotification != null && androidNotification != null) {
//           // NotificationService().showLocalNotification(RemoteMessage());
//           print("foreground onMessage called ${message.data}");
//           print('--------------------------------------------------');

//           var alarmModel = AlarmNotifcationModel.fromJson(message.data);

//           print(
//               "======================PAYLOD ===========================================");
//           print(
//             {
//               "eventId": alarmModel.eventId,
//               "name": alarmModel.name,
//               "sourceId": alarmModel.sourceId,
//               // "multiselectAsset": eventLog.
//             },
//           );

//           showLocalNotification(
//             message,
//             NotificationController.alarmsChannelKey,
//             payload: {
//               "eventId": alarmModel.eventId,
//               "name": alarmModel.name,
//               "sourceId": alarmModel.sourceId,
//               // "multiselectAsset": eventLog.
//             },
//           );
//         } else {
//           print("REMOTE NOTIFICATION ELSE CALLED");
//         }
//       });
//     } on FirebaseException catch (e) {
//       print("foreground handler firebase catch bloc called");
//       print(e.message);
//     } catch (e) {
//       print("foreground handler catch bloc called");
//       print(e);
//     }
//   }

// //  =====================================================================================
// // This method is used to checking the notification allowed o

//   Future<bool> checkNotificationPermission() async {
//     bool? notFirstTime = SharedPrefrencesServices().getFirstTimeStore();

//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

//     print("Notification permission $isAllowed");

//     if (!isAllowed) {
//       if (notFirstTime == null) {
//         isAllowed =
//             await AwesomeNotifications().requestPermissionToSendNotifications();
//         SharedPrefrencesServices().firstTimeStore();
//       }

//       return isAllowed;
//     }

//     return isAllowed;
//   }

  // ==================================================================================
  // Subcribe topic or unsubscribe topic.

  Future<void> firebaseMessagingSubcribeOrUnsubcribeTopic({
    required bool subcribe,
  }) async {
    FirebaseMessagingServices firebaseMessaging = FirebaseMessagingServices();

    String domain = userData.domain;

    String topicStart = "nectarassets-events";

    String? token = await firebaseMessaging.firebaseMessaging.getToken();


    if (subcribe) {
      await firebaseMessaging.topicSubscribeHandler(
          subscribe: true, topic: "$topicStart-CRITICAL-$domain");

      await firebaseMessaging.topicSubscribeHandler(
          subscribe: true, topic: "$topicStart-HIGH-$domain");

      await firebaseMessaging.topicSubscribeHandler(
          subscribe: true, topic: "$topicStart-MEDIUM-$domain");

      await firebaseMessaging.topicSubscribeHandler(
          subscribe: true, topic: "$topicStart-LOW-$domain");

      await firebaseMessaging.topicSubscribeHandler(
          subscribe: true, topic: "$topicStart-WARNING-$domain");
      return;
    }

    await firebaseMessaging.topicSubscribeHandler(
        subscribe: false, topic: "$topicStart-CRITICAL-$domain");

    await firebaseMessaging.topicSubscribeHandler(
        subscribe: false, topic: "$topicStart-HIGH-$domain");

    await firebaseMessaging.topicSubscribeHandler(
        subscribe: false, topic: "$topicStart-MEDIUM-$domain");

    await firebaseMessaging.topicSubscribeHandler(
        subscribe: false, topic: "$topicStart-LOW-$domain");

    await firebaseMessaging.topicSubscribeHandler(
        subscribe: false, topic: "$topicStart-WARNING-$domain");
  }
}
