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
          Text('Profile'),
        ],
      ));
}

List<QudsPopupMenuBase> getMenuItems() {
  return [
    QudsPopupMenuItem(
        leading: Icon(Icons.online_prediction_rounded),
        title: Text('Orders'),
        subTitle: Text('See your orders'),
        onPressed: () {
          Get.offAllNamed(Routes.PROFILE_SCREEN);
        }),
    QudsPopupMenuDivider(),
    QudsPopupMenuItem(
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
        onPressed: () {
          AuthService.instance.cleanStorage();
          Get.offAllNamed(Routes.HOME);
        }),
  ];
}
