// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:webuywesell/app/routes/app_pages.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';
import 'package:webuywesell/app/services/auth/auth_service.dart';
import 'app/core/utils/helpers/logger.dart';
import 'app/core/widgets/global_errorwidget.dart';
import 'app/core/locators/service_locator.dart';
import 'app/data/supabase/credientials.dart';

SupabaseConfigModel get currentEnv => EnvConfig.getCurrentENV(Env.dev);
final supbaseClient = Supabase.instance.client;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.error(details.toString());
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error('Async error: $error');
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return GlobalErrorWidget(errorDetails: errorDetails);
  };
  await _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  initDependencies();
  AppLogger.info('initialized');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade my device',
      builder: (context, widget) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: ResponsiveBreakpoints.builder(
              child: widget!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ));
      },
      theme: lightThemeData(context),
      themeMode: ThemeMode.light,
      useInheritedMediaQuery: true,
      defaultTransition: Transition.fadeIn,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      enableLog: false,
      supportedLocales: const [Locale('en', 'US')],
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppPages.INITIAL,
      navigatorObservers: [GetObserver()],
      getPages: AppPages.routes,
    );
  }
}

showPopupWidget() {
  return QudsPopupButton(
    // backgroundColor: Colors.red,
    tooltip: 'T',
    items: getMenuItems(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xffFFF2E6),
          child: Center(
            child: Icon(Icons.person),
          ),
        ),
        Text(AuthService.instance.authCustomer?.email ?? '',
            style: defaultTextStyle),
      ],
    ),
  );
}

List<QudsPopupMenuBase> getMenuItems() {
  return [
    QudsPopupMenuSection(
        backgroundColor: Colors.yellow.shade200,
        titleText: 'Visit',
        subTitle: Text('See your profile'),
        leading: Icon(
          Icons.redeem,
          size: 40,
        ),
        
        subItems: [
          QudsPopupMenuSection(
              titleText: 'Settings',
              leading: Icon(Icons.settings),
              subItems: [
                QudsPopupMenuItem(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onPressed: () {})
              ]),
        ]),
    QudsPopupMenuDivider(),
    QudsPopupMenuItem(
        leading: Icon(Icons.info_outline),
        title: Text('Give Feedback'),
        subTitle: Text('Help us improve our new app'),
        onPressed: () {}),
    QudsPopupMenuDivider(),
    QudsPopupMenuSection(
        leading: Icon(Icons.place),
        titleText: 'Settings & Privacy',
        subItems: [
          QudsPopupMenuItem(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onPressed: () {}),
          QudsPopupMenuItem(
              leading: Icon(Icons.lock),
              title: Text('Privacy Checkup'),
              onPressed: () {}),
          QudsPopupMenuItem(
              leading: Icon(Icons.lock_clock),
              title: Text('Privacy Shortcuts'),
              onPressed: () {}),
          QudsPopupMenuItem(
              leading: Icon(Icons.list),
              title: Text('Activity Log'),
              onPressed: () {}),
          QudsPopupMenuItem(
              leading: Icon(Icons.card_membership),
              title: Text('News Feed Preferences'),
              onPressed: () {}),
          QudsPopupMenuItem(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onPressed: () {}),
        ]),
    QudsPopupMenuDivider(),
    QudsPopupMenuWidget(
        builder: (c) => Container(
            padding: EdgeInsets.all(10),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
                  VerticalDivider(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.music_note,
                        color: Colors.blue,
                      )),
                  VerticalDivider(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.umbrella,
                        color: Colors.green,
                      ))
                ],
              ),
            )))
  ];
}
