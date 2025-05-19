import 'dart:async';

import 'package:coinswitch/screen/createAccount.dart';
import 'package:coinswitch/screen/home.dart';
import 'package:coinswitch/service/setupApiLocation.dart';
import 'package:coinswitch/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupApplication();
  // await dotenv.load();
  await _setupNotifications();
  runApp(MyApp());
}

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _setupNotifications() async {
  const InitializationSettings settings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  await localNotificationsPlugin.initialize(settings).then((_) {
    debugPrint('Local Notifications setup success');
  }).catchError((Object error) {
    debugPrint('Local Notifications setup error: $error');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    // _initDeepLink();
  }

  // void _initDeepLink() {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     if (uri != null) {
  //       debugPrint("Deep Link URI: ${uri.toString()}");
  //       if (uri.toString() == "coinswitch://home") {
  //         Get.offAllNamed("/home"); // Navigate to home screen
  //       }
  //     }
  //   }, onError: (err) {
  //     debugPrint("Deep Link Error: $err");
  //   });
  // }

  // @override
  // void dispose() {
  //   _sub?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.appLightTheme,
          home: const CreateAccount(),
          // initialRoute: "/",
          // getPages: [
          //   GetPage(name: "/", page: () => const CreateAccount()),
          //   GetPage(name: "/home", page: () => Home_Screen()),
          // ],
        );
      },
    );
  }
}
