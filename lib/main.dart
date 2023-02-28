import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:send_me/constants/theme.dart';
import 'package:send_me/core/services/navigation_service.dart';
import 'package:send_me/core/services/snackbar_services.dart';
import '_lib.dart';

//Death1800.

Future<void> _messageHandler(RemoteMessage message) async {}

void main() async {
  setupServices();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // runApp(new MaterialApp(
  //   home: new UiTest(),
  // ));
  runApp(ProviderScope(child: Consumer(builder: (context, watch, _) {
    final vm = watch.watch(themeVm);
    return MyApp(
      theme: vm.themeMode,
    );
  })));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  ThemeMode? theme;
  MyApp({Key? key, this.theme}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    return DismissableKeyboardFeature(
      child: ScreenUtilInit(
          designSize: const Size(414, 977),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appTitle,
              builder: (context, child) => Navigator(
                key: locator<ProgressService>().progressNavigationKey,
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) {
                    return ProgressManager(child: child!);
                  },
                ),
              ),
              scaffoldMessengerKey:
                  locator<SnackBarService>().scaffoldMessengerKey,
              navigatorKey: locator<NavigationService>().navigationKey,
              theme: AppTheme.lightTheme,
              home: const SplashScreen(),
              onGenerateRoute: generateRoute,
            );
          }),
    );
  }
}
