import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/tabs/welcomeSplash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDLy9Jy1Dks5ESr7678CnxdPl3z2ww02Gc",
      appId: "1:317266933717:android:e4d559ed48717c14d82f5c",
      messagingSenderId: "317266933717	",
      projectId: "travel-app-e8dd8",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) {
          return const MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              home: SafeArea(child: WelcomeSplash()));
        });
  }
}
