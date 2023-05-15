import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';

import 'package:probot/controllers/common_controllers/ad_controller.dart';

import 'package:probot/controllers/common_controllers/text_to_speech_controller.dart';

import 'common/languages/index.dart';

import 'config.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  Get.put(AdController());
  Get.put(TextToSpeechController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    lockScreenPortrait();
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> statusSnapshot) {
          log("STATUS : ${statusSnapshot.data}");

          return  GetMaterialApp(
                  themeMode: ThemeService().theme,
                  theme: AppTheme.fromType(ThemeType.light).themeData,
                  darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                  locale: const Locale('en', 'US'),
                  translations: Language(),
                  fallbackLocale: const Locale('en', 'US'),
                  home:SplashScreen(),
                  title: appFonts.proBot.tr,
                  getPages: appRoute.getPages,
                  debugShowCheckedModeBanner: false);

        });
  }

  lockScreenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
