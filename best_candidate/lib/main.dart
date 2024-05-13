import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

void main() {
    MpesaFlutterPlugin.setConsumerKey(ConstanceData.consumerKey);
  MpesaFlutterPlugin.setConsumerSecret(ConstanceData.consumerSecret);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Candidate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => SplashScreen(),
        '/home':(context) =>  Home(),
      },
    );
  }
}

