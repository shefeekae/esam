// // import 'package:awesome_notifications/awesome_notifications.dart';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:nectar_assets/core/services/notifications/notification_services.dart';
// import 'package:nectar_assets/core/services/sharedprefrence_services.dart';

// import '../../ui/pages/login/login_screen.dart';
// import '../schemas/login_schema.dart';
// import 'graphql_services.dart';

// class UserAuthService {
//   GraphqlServices graphqlServices = GraphqlServices();

//   // String criticalities = "CRITICAL-HIGH-MEDIUM-LOW-WARNING";

//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
// // =======================

//   Future<String> loginMethod(
//     String username,
//     String password,
//   ) async {
//     // ValueNotifier<GraphQLClient> client = EndPoint().getClient();
//     try {
//       QueryResult result = await graphqlServices.performQuery(
//         query: LoginSchema.getLoginJson,
//         variables: {
//           "credentials": {
//             "userName": username,
//             "password": password,
//           },
//           "isDevMode": true,
//           "origin": "mobile",
//         },
//       );

//       if (result.hasException) {
//         print(result.exception);
//         if (result.exception!.graphqlErrors.isNotEmpty) {
//           String errorMessage = result.exception!.graphqlErrors[0]
//               .extensions!['response']['body']['errorMessage'];
//           return errorMessage;
//         }

//         print("ERROR MESSAGE");
//         ConnectivityResult connectivityResult =
//             await Connectivity().checkConnectivity();

//         if (connectivityResult == ConnectivityResult.none) {
//           return "No Internet connection";
//         }

//         // print(errorMessage);
//         // return result.exception.toString();
//         return "Something went wrong!! Try again";
//       }

//       // print(result.data?["login"]['user']['data']['employeeId']);

//       Map<String, dynamic> loginresponse = result.data!['login'];
//       Map<String, dynamic> userdata = result.data!['login']['user']['data'];

//       String refreshToken = loginresponse['refreshToken'];
//       String accessToken = loginresponse['accessToken'];
//       String domain = userdata['domain'];
//       String role = userdata['roleName'];
//       String identifier = userdata['identifier'];
//       String userName = userdata['firstName'] + ' ' + userdata['lastName'];
//       String contactNumber = userdata['contactNumber'];
//       String emailId = userdata['emailId'];

//       Map<String, dynamic> userInfomations = {
//         "accessToken": accessToken,
//         "refreshToken": refreshToken,
//         "domain": domain,
//         "role": role,
//         "identifier": identifier,
//         "userName": userName,
//         "contactNumber": contactNumber,
//         "emailId": emailId
//       };

//       SharedPrefrencesServices().saveUserInformations(userInfomations);

      // await NotificationService()
      //     .firebaseMessagingSubcribeOrUnsubcribeTopic(subcribe: true);

//       return "";
//     } catch (e) {
//       print(e);
//       print("catch bloc called");
//       return "someting went wrong. Please try again.";
//     }
//   }

//   // ===========================================================================================
//   // This method is used to logout the current user.

//   logOut(BuildContext context) async {
//     SharedPrefrencesServices.removeRemindMe();

//     await NotificationService()
//         .firebaseMessagingSubcribeOrUnsubcribeTopic(subcribe: false);
        
        
      

//     Future.delayed(const Duration(milliseconds: 100), () {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
//     });

//     // ignore: use_build_context_synchronously
//   }

//   // ===================================================================================================================================================
//   // This method is used to when the accessToken expired this function will be called and update the new accessToken in sharedprefrence and graphqlclient.

//   Future<bool?> refreshToken(BuildContext context) async {
//     // GraphqlServices graphqlServices = GraphqlServices();
//     try {
//       // GraphQLClient client = EndPoint().getClient().value;

//       String refreshtoken =
//           SharedPrefrencesServices().getUserInformation("refreshToken")!;

//       String domain = SharedPrefrencesServices().getUserInformation("domain")!;

//       String role = SharedPrefrencesServices().getUserInformation("role")!;

//       String identifier =
//           SharedPrefrencesServices().getUserInformation("identifier")!;

//       var result = await graphqlServices.performMutation(
//         refreshTokenCalled: true,
//         query: LoginSchema.refreshtoken,
//         variables: {
//           "refreshToken": refreshtoken,
//         },
//       );

//       if (result.hasException) {
//         print(result.exception);

//         print("refresh Token Exception called");
//         return false;
//       }

//       var refresh = result.data!['refresh'];

//       print(result.data);

//       if (refresh.isEmpty) {
//         // print("Refresh key is empty");
//         // print(result.data);
//         return false;
//       }

//       print("old refreshToken : $refreshtoken");

//       refreshtoken = refresh['refreshToken'];
//       String accessToken = refresh['accessToken'];

//       print("new refresh Token : $refreshtoken");

//       Map<String, dynamic> userInfomations = {
//         "accessToken": accessToken,
//         "refreshToken": refreshtoken,
//         "domain": domain,
//         "role": role,
//         "identifier": identifier,
//       };

//       print(userInfomations);

//       SharedPrefrencesServices().saveUserInformations(userInfomations);
//       return true;
//     } catch (e) {
//       print("refresh token catch bloc called");
//       print(e);
//       return null;
//     }
//   }

//   // ===================================================================================
//   // Helper method for refresh token.

//   callRefreshToken({
//     required BuildContext context,
//     required Future<QueryResult<Object?>?> Function()? refetch,
//     Function(void Function())? setState,
//   }) {
//     refreshToken(context).then((value) {
//       print("refresh token $value");
//       Future.delayed(const Duration(seconds: 1), () {
//         if (value == null || !value) {
//           // setState(() {});
//           // refetch!.call();
//           logOut(context);

//           print("refresh token return value $value");
//         } else if (value) {
//           print("true called");
//           // EndPoint().getClient();
//           if (refetch == null) {
//             setState!(() {});
//             return;
//           }
//           refetch.call();
//         }
//       });
//     });
//   }
// }
