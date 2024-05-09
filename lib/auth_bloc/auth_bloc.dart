
// Flutter imports:
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_assigned/homescreen.dart';

// Project imports:
import '../authentications/otp_verification.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpUsingMobileNumber>(_signUpUsingPhone);
    on<OtpVerification>(_otpVerify);
  }
  void _signUpUsingPhone(
    SignUpUsingMobileNumber event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      verificationCompleted(AuthCredential credential) async {
        emit(AuthLoaded());
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the main screen
        // Example: Get.offAll(MainScreen());
      }

      verificationFailed(FirebaseAuthException e) {
        debugPrint(
            'Error verifying phone number: ${event.countyCode}${event.phoneNumber}, error: ${e.message}');
        Get.snackbar(
          'Error',
          'Failed to verify phone number',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }

      codeSent(String verificationId, int? resendToken) async {
        await Get.to(() => OtpScreen(
              verificationId: verificationId,
              resendToken: resendToken,
              phoneNumber: event.phoneNumber,
              countryCode: event.countyCode,
            ));
        emit(codeSent(verificationId, resendToken));
      }

      codeAutoRetrievalTimeout(String verificationId) {
        if (kDebugMode) {
          print('codeAutoRetrievalTimeout: $verificationId');
        }
        emit(codeAutoRetrievalTimeout(verificationId));
        AuthError();
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      debugPrint(
          'Error verifying phone number: ${event.countyCode}, error: $e');
      Get.snackbar(
        'Error',
        'Failed to verify phone number',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      emit(AuthError());
    }
  }

  void _otpVerify(
    OtpVerification event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpsent,
      );
      emit(AuthLoaded());
      await FirebaseAuth.instance.signInWithCredential(credential);
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
         Get.to( HomeScreen());
      } else {
        log("Invalid user credentials");
        emit(AuthError());
      }
    } on FirebaseAuthException {
      log("Please Input Valid Otp");
      emit(AuthError());
    }
  }

  String token = "";
}
