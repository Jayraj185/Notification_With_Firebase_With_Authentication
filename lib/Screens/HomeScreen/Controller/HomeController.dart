import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notification_with_firebase/Utils/ToastMessage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notification_with_firebase/Utils/FirebaseHelper/FirebaseHelper.dart';

class HomeController extends GetxController
{
  TextEditingController txtSignUpEmail = TextEditingController();
  TextEditingController txtSignUpPass = TextEditingController();
  TextEditingController txtSignInEmail = TextEditingController();
  TextEditingController txtSignInPass = TextEditingController();
  RxBool SignUp_password_vis = true.obs;
  RxBool SignIn_password_vis = true.obs;
  GlobalKey<FormState> SignUpkey = GlobalKey<FormState>();
  GlobalKey<FormState> SignInkey = GlobalKey<FormState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  //Check Login User In Authentication
  Future<void> IsLogin()
  async {
    bool Login = await FirebaseHelper.firebaseHelper.CheckUserLogin();

    if(Login)
      {
        Timer(const Duration(seconds: 3), () {
          Get.offNamed('Home');
        });
      }
    else
      {
        Timer(const Duration(seconds: 3), () {
          Get.offNamed('SignIn');
        });
      }
  }

  //================================ NOTIFICATION ===========================

  //Initialize Notification
  void InitializeNotification() async
  {
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('icon');

    DarwinInitializationSettings iOSInitializationSettings = const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: iOSInitializationSettings);

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

  //Show Simple Notification
  Future<void> ShowSimpleNotification()
  async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
    );

    DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(subtitle: "IOS",);

    NotificationDetails notificationDetails =  NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.show(1, "Hello Everyone", "Flutter Simple Notification Testing", notificationDetails).then((value) => ToastMessage(msg: "Successful", color: Colors.green)).catchError((error) => ToastMessage(msg: "$error", color: Colors.red));
  }

  //Show Sound & Image Notification
  Future<void> ShowSoundImageNotification()
  async {

    // final Directory directory = await getApplicationDocumentsDirectory();
    // final String filePath = "${directory.path}/bigPicture";
    var response = await http.get(Uri.parse("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"));
    // final File file = File(filePath);
    // await file.writeAsBytes(response.bodyBytes);
    final ByteArrayAndroidBitmap bigPicturePath = await ByteArrayAndroidBitmap(response.bodyBytes);
    final ByteArrayAndroidBitmap largeIconPath =await ByteArrayAndroidBitmap(response.bodyBytes);

    BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
        bigPicturePath,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);

    AndroidNotificationDetails androidNotificationDetails =  AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('sound'),
      styleInformation: bigPictureStyleInformation
    );

    DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(subtitle: "IOS",);

    NotificationDetails notificationDetails =  NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.show(1, "Hello Everyone", "Flutter Sound And Image Notification Testing", notificationDetails).then((value) => ToastMessage(msg: "Successful", color: Colors.green)).catchError((error) => ToastMessage(msg: "$error", color: Colors.red));
  }

  //Show Schedule Notification
  Future<void> ShowScheduleNotification()
  async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
    );

    DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(subtitle: "IOS",);

    NotificationDetails notificationDetails =  NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Hello Everyone",
        "Flutter Schedule Notification Testing",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    ).then((value) => ToastMessage(msg: "Successful", color: Colors.green)).catchError((error) => ToastMessage(msg: "$error", color: Colors.red));
  }
}