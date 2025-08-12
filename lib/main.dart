import 'dart:async';

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/websocketServices.dart';
import 'package:coinswitch/model/availablecrypto.dart';
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
  Get.put(AllAvailableAddress());
  Get.put(Availablecrypto());
  Get.put(WebSocketController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
