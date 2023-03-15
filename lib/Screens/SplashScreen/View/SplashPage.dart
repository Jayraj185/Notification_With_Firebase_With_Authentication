import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_with_firebase/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.IsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/2.1,left: Get.width/12),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 33.sp,

                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/2.4,left: Get.width/12),
                child: Text(
                  "Sign in to your Registered Account.",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 13.sp,

                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: EdgeInsets.only(bottom: Get.width/2.8,left: Get.width/12),
                  child: Container(
                    height: Get.height/150,
                    width: Get.width/7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purpleAccent.shade100,
                    ),
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/6),
                child: CircularProgressIndicator(color: Colors.purpleAccent.shade100,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
