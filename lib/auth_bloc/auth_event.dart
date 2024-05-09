part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpUsingMobileNumber extends AuthEvent {
  final String phoneNumber;
  final String countyCode;

  SignUpUsingMobileNumber(
      {required this.phoneNumber, required this.countyCode});
}

class OtpVerification extends AuthEvent {
  final String otpsent;
  final String verificationId;

  OtpVerification({
    required this.otpsent,
    required this.verificationId,
  });
}
