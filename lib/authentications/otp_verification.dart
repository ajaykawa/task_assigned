// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../auth_bloc/auth_bloc.dart';

// Project imports:

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String? verificationId;
  final int? resendToken;
  const OtpScreen({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
    this.verificationId,
    this.resendToken,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pin = TextEditingController();

  bool isChecked = false;
  bool _showTimer = false;
  int _countdown = 59;
  String? otppin;
  Timer? _timer;
  final TextEditingController _otpcontroller = TextEditingController();
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _showTimer = true;
      _countdown = 59;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _showTimer = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        const Center(
                          child: Text(
                            'Enter 6 digit OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Verification has been sent to  ${widget.phoneNumber}\n ',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: PinInputTextField(
                              controller: _otpcontroller,
                              onSubmit: (value) {
                                otppin == value;
                              },
                              enabled: true,
                              decoration: BoxLooseDecoration(
                                  hintText: '000000',
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  strokeColorBuilder: PinListenColorBuilder(
                                      Colors.grey, Colors.white),
                                  hintTextStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey))),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  OtpVerification(
                                      otpsent: _otpcontroller.text,
                                      verificationId:
                                          widget.verificationId!));
                              _otpcontroller.clear();
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: const [
                                      0.1,
                                      0.4,
                                      0.6,
                                      0.9,
                                    ],
                                    colors: [
                                      Colors.red.shade600,
                                      Colors.red.shade300,
                                      Colors.red.shade200,
                                      Colors.red.shade600,
                                    ],
                                  )),
                              child: const Center(
                                child: Text('Verify',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Didn't Received the  code ?",
                                style: TextStyle(fontSize: 16,color: Colors.white)),
                            TextButton(
                              onPressed: _showTimer
                                  ? null
                                  : () {
                                      if (kDebugMode) {
                                        print("Resend OTP");
                                      }
                                      startTimer();
                                    },
                              child: _showTimer
                                  ? Text(
                                      ' $_countdown',
                                      style: const TextStyle(fontSize: 16,color: Colors.white),
                                    )
                                  : Text(
                                      'Resend OTP',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red.shade200),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
