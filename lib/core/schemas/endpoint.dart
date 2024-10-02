// import 'package:flutter/widgets.dart';
// import '../../utils/constants/urls.dart';
// import '../services/sharedprefrence_services.dart';

// class EndPoint {
//   static ValueNotifier<GraphQLClient> getClient({required String timeZone}) {
//     print(
//         "GET CLIENT CALLED ========================================================================");

//     // HttpLink httpLink = HttpLink(
//     //   endpointUrl,
//     //   // defaultHeaders: {
//     //   //   "Authorization": "Bearer $accessToken",
//     //   // },
//     // // );

//     // SecurityContext context = SecurityContext.defaultContext;
//     // context.allowLegacyUnsafeRenegotiation = true;

//     // HttpClient http = HttpClient(context: context);
//     // http.findProxy = null;

//     // final httpClient = IOClient(http

//     print("Endpoint Url $endpointUrl");

//     HttpLink httpLink = HttpLink(
//       endpointUrl,
//       defaultHeaders: {
//         "Connection": "Keep-Alive",
//         'Content-Type': 'application/json',
//         'Accept-Charset': 'utf-8',
//         "timezone": timeZone,
//         "locale": "en-US",
//         // "locale": "ml-IN",
//       },
//     );

//     print("Headers ${httpLink.defaultHeaders}");

//     AuthLink authLink = AuthLink(
//       getToken: () async {
//         String? accessToken =
//             SharedPrefrencesServices().getUserInformation("accessToken");

//         print("AuthLink called------------$accessToken----------------");
//         print("accessToken : $accessToken");

//         return 'Bearer $accessToken';
//       },
//     );

//     Link link = authLink.concat(httpLink);

//     ValueNotifier<GraphQLClient> client = ValueNotifier(
//       GraphQLClient(
//         link: link,
//         cache: GraphQLCache(
//           store: null,
//         ),
//       ),
//     );

//     return client;
//   }
// }
