import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_with_firebase/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notification_with_firebase/Utils/ApiHttp.dart';
import 'package:notification_with_firebase/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:notification_with_firebase/Utils/ToastMessage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    homeController.InitializeNotification();
    FirebaseHelper.firebaseHelper.FirebaseMessageging();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
          leading: Padding(
            padding: EdgeInsets.only(left: Get.width / 60),
            child: IconButton(
              onPressed: () async {
                await FirebaseHelper.firebaseHelper.SignOutUser();
                Get.offNamed('SignIn');
                ToastMessage(msg: "Log Out Successful", color: Colors.green);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  homeController.ShowSimpleNotification();
                },
                child: Text("Simple Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
              ),
              SizedBox(height: Get.width/15,),
              ElevatedButton(
                onPressed: () {
                  homeController.ShowScheduleNotification();
                },
                child: Text("Schedule Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
              ),
              SizedBox(height: Get.width/15,),
              ElevatedButton(
                onPressed: () {
                  homeController.ShowSoundImageNotification();
                },
                child: Text("Sound & Image Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
              ),
              SizedBox(height: Get.width/15,),
              ElevatedButton(
                onPressed: () {
                  ApiHttp.apiHttp.PostEmailPass(title: "Firebase Notification", body: "Flutter Firebase Notification Testing");
                },
                child: Text("Firebase Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
