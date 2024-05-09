// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assigned/custom_text.dart';

// Project imports:
import '../auth_bloc/auth_bloc.dart';
import '../main.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController phone = TextEditingController();
  CountryCode? _selectedCountryCode;
  bool isChecked = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Enter Your Number',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            TextFormField(
                              // maxLength: 15,
                              validator: (value) {
                                if (value!.length < 4) {
                                  return 'Input the valid details!';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              controller: phone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[\d+]'))
                              ],
                              decoration: InputDecoration(
                                hintText: 'Enter your phone number',
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        width: 4, color: Colors.white)),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                      style: BorderStyle.solid),
                                ),
                                prefixIcon: CountryCodePicker(
                                  textStyle: const TextStyle(color: Colors.white),
                                  onChanged: (code) {
                                    setState(() {
                                      _selectedCountryCode = code;
                                    });
                                  },
                                  initialSelection: 'IN',
                                  favorite: const ['+91', 'IN'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  showDropDownButton: false,
                                ),
                                // Add minLength and maxLength properties here
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                      Object countryCode =
                                          _selectedCountryCode ?? '+91';

                                      BlocProvider.of<AuthBloc>(context).add(
                                        SignUpUsingMobileNumber(
                                          phoneNumber:
                                              '$countryCode${phone.text}',
                                          countyCode: countryCode.toString(),
                                        ),
                                      );

                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    backgroundColor:
                                        Colors.red.withOpacity(0.2),
                                    disabledForegroundColor: Colors.red,
                                    disabledBackgroundColor: Colors.red,
                                    padding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: const BorderSide(
                                            color: Colors.white, width: 0.5)),
                                  ),
                                  child: const CustomText(
                                    text: 'Sign up',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
