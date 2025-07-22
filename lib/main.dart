import 'dart:async';

import 'package:coinswitch/screen/mnemonic.dart';
import 'package:coinswitch/service/setupApiLocation.dart';
import 'package:coinswitch/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.development");
  await setupApplication();
  runApp(MyApp());
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
          home: const WalletMnemonic(),
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
