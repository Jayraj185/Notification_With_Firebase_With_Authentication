import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_with_firebase/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notification_with_firebase/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:notification_with_firebase/Utils/ToastMessage.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: homeController.SignUpkey,
        child: Scaffold(
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: Get.height / 3,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Text("Welcome",style: TextStyle(color: Colors.purpleAccent, fontSize: 50.sp, fontWeight: FontWeight.bold),)
                ),
              ),
              Container(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.width / 1.6, left: Get.width / 12),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 33.sp,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.width / 60),
                            child: Text(
                              "Register with your valid email address",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: Get.height / 150,
                            width: Get.width / 7,
                            margin: EdgeInsets.only(top: Get.width / 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.purpleAccent.shade100,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.width / 12),
                            child: Text(
                              "Email Address",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: Get.width / 30, right: Get.width / 12),
                              child: TextFormField(
                                controller: homeController.txtSignUpEmail,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.purpleAccent.shade100,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.purpleAccent.shade100),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.purpleAccent.shade100),
                                      borderRadius: BorderRadius.circular(9)),
                                  hintText: "Enter Email Ex. xyz123@gmail.com",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.purpleAccent.shade100,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Your Email";
                                  } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Please Enter Valid Email";
                                  }
                                  return null;
                                },
                              )),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.width / 15),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.width / 30, right: Get.width / 12),
                            child: Obx(
                                  () => TextFormField(
                                controller: homeController.txtSignUpPass,
                                keyboardType: TextInputType.name,
                                cursorColor: Colors.purpleAccent.shade100,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.purpleAccent.shade100),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.purpleAccent.shade100),
                                      borderRadius: BorderRadius.circular(9)),
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.purpleAccent.shade100,
                                  ),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        homeController.SignUp_password_vis.value =
                                        !homeController
                                            .SignUp_password_vis.value;
                                      },
                                      child: Icon(
                                        homeController.SignUp_password_vis.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.purpleAccent.shade100,
                                      )),
                                ),
                                obscureText:
                                homeController.SignUp_password_vis.value,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Your Password";
                                  } else if (value.length != 6) {
                                    return "Please Enter Maximum 6 Letter";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.width / 30, right: Get.width / 9),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: Colors.purpleAccent.shade100,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (homeController.SignUpkey.currentState!
                                .validate()) {
                              bool isSignUp = await FirebaseHelper.firebaseHelper.SignUpUser(email: homeController.txtSignUpEmail.value.text, password: homeController.txtSignUpPass.value.text);

                              if (isSignUp) {
                                Get.back();
                                homeController.txtSignUpEmail.clear();
                                homeController.txtSignUpPass.clear();
                                homeController.SignUp_password_vis.value = true;
                              } else {
                              }
                            } else {
                              ToastMessage(msg: "Please Add Your Email Or Password", color: Colors.red);
                            }
                          },
                          child: Container(
                            height: Get.height / 18,
                            width: Get.width / 3,
                            margin: EdgeInsets.only(
                                top: Get.width / 12, right: Get.width / 12),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.purpleAccent.shade100,
                                  Colors.purpleAccent,
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.purpleAccent.shade100,
                                      blurRadius: 15,
                                      offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            alignment: Alignment.center,
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.width / 21, right: Get.width / 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Already Have Account",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: Get.width / 90,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  homeController.txtSignUpEmail.clear();
                                  homeController.txtSignUpPass.clear();
                                  homeController.SignUp_password_vis.value = true;
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
