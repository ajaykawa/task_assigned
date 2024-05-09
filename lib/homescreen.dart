import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.black,
        child: Center(
          child: Text("Welcome to home screen"),
        ),
      ),
    );
  }
}
