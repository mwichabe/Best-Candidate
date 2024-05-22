import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/firebase_options.dart';
import 'package:best_candidate/introduction/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   // MpesaFlutterPlugin.setConsumerKey(ConstanceData.consumerKey);
  //MpesaFlutterPlugin.setConsumerSecret(ConstanceData.consumerSecret);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

