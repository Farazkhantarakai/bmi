import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import './screens/home_page.dart';
import './screens/result_page.dart';
import './screens/splash_screen.dart';
import './widgets/information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeAds();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Color(0xFF000000),
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   systemNavigationBarDividerColor: null,
  //   statusBarColor: Color.fromARGB(255, 165, 152, 152),
  //   statusBarIconBrightness: Brightness.light,
  //   statusBarBrightness: Brightness.dark,
  // ));
  //actualy this is using
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(RequestConfiguration(
        // testDeviceIds: ['68961AC5B404C11EFE4CB5C0EFBA03BC']
        ));
  runApp(const MyApp());
}

Future<InitializationStatus> initializeAds() async {
  return await MobileAds.instance.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isAdBannerReady = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light))),
      // theme: data.Theme.light(),
      initialRoute: SplashScreen.routName,
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routName: ((context) => const HomePage()),
        Result.routName: ((context) => const Result()),
        InformationWidget.routName: ((context) => const InformationWidget()),
        SplashScreen.routName: (((context) {
          return const SplashScreen();
        }))
      },
    );
  }
}
