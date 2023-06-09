import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notification_with_firebase/Screens/HomeScreen/View/HomePage.dart';
import 'package:notification_with_firebase/Screens/SignInScreen/View/SignInPage.dart';
import 'package:notification_with_firebase/Screens/SignUpScreen/View/SignUpPage.dart';
import 'package:notification_with_firebase/Screens/SplashScreen/View/SplashPage.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashPage(),
            'SignIn': (context) => SignInPage(),
            'SignUp': (context) => SignUpPage(),
            'Home': (context) => HomePage(),
          },
        );
      },
    ),
  );
}
