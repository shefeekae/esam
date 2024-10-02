import 'package:app_filter_form/app_filter_form.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_config/firebase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/blocs/Home/bloc/indicators_controller_bloc.dart';
import 'package:nectar_assets/core/blocs/alarms/count/alarms_count_bloc.dart';
import 'package:nectar_assets/core/blocs/alarms/pagination/pagination_bloc.dart';
import 'package:nectar_assets/core/blocs/alarms/suspect%20points/suspectpoints_bloc.dart';
import 'package:nectar_assets/core/blocs/pagination%20controller/pagination_controller_bloc.dart';
import 'package:nectar_assets/core/blocs/theme/theme_bloc.dart';
import 'package:nectar_assets/core/services/theme/app_theme_data_service.dart';
import 'package:nectar_assets/core/services/user_auth_helpers.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/communites_insights_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/site/site_building_profile.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equipment_data_trends_screen.dart';
import 'package:nectar_assets/ui/pages/splash/splash_screen.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:nectar_assets/utils/routes/named_routes.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:video_tutorials/video_tutorials.dart';
import 'core/blocs/appbar count/appbar_count_bloc.dart';
import 'core/blocs/assets/segmantedButtons/segmated_buttons_bloc.dart';
import 'core/models/communities/community_hierarchy_args_model.dart';
import 'core/services/notifications/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String timeZone = await FlutterNativeTimezone.getLocalTimezone();

  await FirebaseConfig().init();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  NotificationController.awesomeNotificationinitialise();

  await VideoTutorialDbServices().initDb();
  await VideoTutorialDbServices().registerAdapterandOpenBox();

  await StorageServices().init();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IndicatorsControllerBloc(),
        ),
        BlocProvider(
          create: (context) => SegmatedButtonsBloc(),
        ),
        BlocProvider(
          create: (context) => AlarmsCountBloc(),
        ),
        BlocProvider(
          create: (context) => FilterSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => PayloadManagementBloc(),
        ),
        BlocProvider(
          create: (context) => FilterAppliedBloc(),
        ),
        BlocProvider(
          create: (context) => ValidatorControllerBlocBloc(),
        ),
        BlocProvider(
          create: (context) => SuspectpointsBloc(),
        ),
        BlocProvider(
          create: (context) => AppbarCountBloc(),
        ),
        BlocProvider(
          create: (context) => PaginationBloc(),
        ),
        BlocProvider(
          create: (context) => PaginationControllerBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: MyApp(
        timeZone: timeZone,
        analytics: analytics,
      ),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({
    required this.timeZone,
    required this.analytics,
    super.key,
  });

  final FirebaseAnalytics analytics;

  final String timeZone;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    var platformBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    bool isDarkMode = SharedPrefrencesServices.instance.getBool("isDarkMode") ??
        platformBrightness == Brightness.dark;

    themeBloc.state.mode = isDarkMode ? ThemMode.dark : ThemMode.light;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GraphQlProviderWidget(
        client: ValueNotifier(
          GrapghQlClientServices().getClient(
            isConnectedinStaging: true,
            exceptionHandler: () async {
              UserAuthHelpers().logOut(context);
            },
            timeZone: widget.timeZone,
            endPointUrl: "https://esam.ecm.ae/api/graphql",
          ),
        ),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            bool lightMode = state.mode == ThemMode.light;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: widget.analytics),
              ],
              routes: namedRoutes,
              navigatorKey: MyApp.navigatorKey,
              theme: AppThemeData().getThemeData(
                  lightMode: lightMode,
                  defaultPrimaryColor: primaryColor,
                  defaultSecondary: primaryColor,
                  defaultAccent: defaultAccent),
              onGenerateRoute: (settings) {
                if (settings.name == CommunityHierarchyScreen.id) {
                  final args = settings.arguments as CommunityHierarchyArgs;

                  // Then, extract the required data from
                  // the arguments and pass the data to the
                  // correct screen.
                  return MaterialPageRoute(
                    builder: (context) {
                      return CommunityHierarchyScreen(
                        insights: args.insights,
                        communityIdentifier: args.communityIdentifier,
                        dropdownData: args.dropdownData,
                        initialDateTimeRange: args.initialDateTimeRange,
                      );
                    },
                  );
                } else if (settings.name == BuildingProfileScreen.id) {
                  final args = settings.arguments as Map<String, dynamic>?;

                  return MaterialPageRoute(
                    builder: (context) => BuildingProfileScreen(
                      siteEntity: args?['siteEntity'] ?? {},
                    ),
                  );
                } else if (settings.name == EquipmentDataTrendsScreen.id) {
                  final args = settings.arguments as Map<String, dynamic>?;

                  return MaterialPageRoute(
                    builder: (context) => EquipmentDataTrendsScreen(
                      criticalPoints: args?['criticalPoints'] ?? [],
                      points: args?['points'] ?? [],
                      identifier: args?['identifier'] ?? "",
                      domain: args?['domain'] ?? "",
                      type: args?['type'] ?? "",
                    ),
                  );
                }

                return null;
              },
              builder: (context, child) => GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child,
              ),
              initialRoute: SplashScreen.id,
            );
          },
        ),
      ),
    );
  }
}
