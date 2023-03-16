import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_with_firebase/Utils/ToastMessage.dart';

class FirebaseHelper
{
  FirebaseHelper._();
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  //========================== Authentication ==============================

  //Sign Up In Firebase Authentication
  Future<bool> SignUpUser({required String email, required String password}) async
  {
    bool isSignUp = false;

    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      isSignUp = true;
      ToastMessage(msg: "Sign Up Successful With $email", color: Colors.green);
    }).catchError((error){
      isSignUp = false;
      ToastMessage(msg: "$error", color: Colors.red);
    });
    return isSignUp;
  }

  //Sign In In Firebase Authentication
  Future<bool> SignInUser({required String email, required String password}) async
  {
    bool isSignIn = false;

    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      isSignIn = true;
      ToastMessage(msg: "Login Successful With $email", color: Colors.green);
    }).catchError((error){
      isSignIn = false;
      ToastMessage(msg: "$error", color: Colors.red);
    });
    return isSignIn;
  }

  //Check User Login In Firebase Authentication
  Future<bool> CheckUserLogin()
  async {
    if(await firebaseAuth.currentUser != null)
      {
        return true;
      }
    return false;
  }

  //Sign Out In Firebase Authentication
  Future<void> SignOutUser()
  async {
    await firebaseAuth.signOut();
  }

  //================================ NOTIFICATION ===========================

  //Set Notification With Firebase Messaging
  Future<void> FirebaseMessageging()
  async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var token = await firebaseMessaging.getToken();
    print("=== TOKEN === $token");
    InitializeNotification();

    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true
    );

    FirebaseMessaging.onMessage.listen((msg) {
      if(msg.notification != null)
        {
          var body = msg.notification!.body.toString();
          var title = msg.notification!.title.toString();
          ShowFirebaseNotification(title: title, body: body);
        }
    });

  }

  //Initialize Notification
  void InitializeNotification()
  {
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('icon');

    DarwinInitializationSettings iOSInitializationSettings = const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: iOSInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

  //Show Simple Notification
  Future<void> ShowFirebaseNotification({required String title, required String body})
  async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('sound'),
    );

    DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(subtitle: "IOS",);

    NotificationDetails notificationDetails =  NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.show(1, title, body, notificationDetails).then((value) => ToastMessage(msg: "Successful", color: Colors.green)).catchError((error) => ToastMessage(msg: "$error", color: Colors.red));
  }
}