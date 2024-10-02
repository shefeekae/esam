// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefrencesServices {
//   static late SharedPreferences instance;

//   void saveUserInformations(Map<String, dynamic> userInfomations) {
//     instance.setString("user", jsonEncode(userInfomations));
//   }

//   String? getUserInformation(String key) {
//     String? userInformations = instance.getString("user");
//     // print(userInformations);
//     if (userInformations == null) {
//       return null;
//     }

//     Map<String, dynamic> user = jsonDecode(userInformations);
//     return user[key];
//   }

//   firstTimeStore() {
//     instance.setBool("not_first_time", true);
//   }

//   bool? getFirstTimeStore() {
//     bool? firstTime = instance.getBool("not_first_time");
//     return firstTime;
//   }

//   static deleteUserInformations() {
//     instance.remove('user');
//   }

//   static void saveUserPincode(String pin) {
//     instance.setString("pin", pin);
//   }

//   static String? getUserPincode() {
//     String? pin = instance.getString("pin");
//     return pin;
//   }

//   static void saveData({required String key, required String value}) {
//     instance.setString(key, value);
//   }

//   static String? getData({required String key}) {
//     String? value = instance.getString(key);
//     return value;
//   }

//   static void removeData({required String key}) {
//     instance.remove(key);
//   }

//   static void storeNotificationContent(
//     Map notificationPayload,
//   ) {
//     String json = jsonEncode(notificationPayload);

//     SharedPrefrencesServices.saveData(
//       key: notificationPayload['id'],
//       value: json,
//     );
//   }

//   // ========================================
//   // Used to store the remind me bool variable.

//   static void storeRemindMe(bool value) {
//     instance.setBool("remindMe", value);
//   }

//   static void removeRemindMe() {
//     instance.remove("remindMe");
//   }

//   // void saveFirebaseTopic({required String identifier,required String domain}){
//   //    instance.sto
//   // }
// }
