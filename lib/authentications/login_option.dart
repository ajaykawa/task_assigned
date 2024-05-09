// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_assigned/custom_text.dart';


// Project imports:
import '../main.dart';
import 'gooleauthentication.dart';
import 'phone_authentication.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.3,
              ),
              InkWell(
                onTap: () {
                  Get.to(const SignUp(isLogin: true));
                },
                child: Container(
                  height: 60,
                  width: width * 0.8,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xff301934),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(Icons.wifi_calling_3_outlined,
                            color: Color(0xff301934)),
                      ),
                      SizedBox(width: width * 0.1),
                      const CustomText(
                        text: "Login with phone",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  try {
                    User? user = await Authentication.signInWithGoogle(
                        context: context);
                  } on PlatformException catch (error) {
                    print("::::::::::::::::::::::::${error.code}");
                    print("::::::::::::::::::::::::${error.details}");
                    print("::::::::::::::::::::::::${error.message}");
                    print("::::::::::::::::::::::::${error.stacktrace}");
                  }
                },
                child: Container(
                  height: 60,
                  width: width * 0.8,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(CupertinoIcons.add_circled),
                      ),
                      SizedBox(width: width * 0.1),
                      const CustomText(
                        text: "Login with Google",
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    color: Colors.white,
                    text: "Don't have an account ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const SignUp(isLogin: true));
                    },
                    child: const CustomText(
                      color: Colors.red,
                      text: 'Sign In',
                      weight: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
