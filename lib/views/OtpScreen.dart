import 'dart:ffi';

import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/viewmodels/login_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/Utils.dart';
import '../core/utils/constants/colors.dart';
import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../routes/routes_names.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  bool isOtpFilled = false;
  bool isLoading = false; // Loader for OTP verification
  bool isResendEmailLoading = false; // Loader for Resend Email Code
  bool isResendPhoneLoading = false; // Loader for Resend Phone Code

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (index) => TextEditingController());
    focusNodes = List.generate(otpLength, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    }
    _checkOtpFilled();
  }

  void _checkOtpFilled() {
    setState(() {
      isOtpFilled = controllers.every(
        (controller) => controller.text.isNotEmpty,
      );
    });
  }

  void _submitOtp() {
    if (!isLoading) {
      setState(() {
        isLoading = true; // Show loader before API call
      });

      String otpCode = controllers.map((controller) => controller.text).join();
      if (otpCode.length == otpLength) {
        _otpVerify(context, otpCode);
      } else {
        setState(() {
          isLoading = false; // Hide loader if OTP is incomplete
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/screen_background.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Image.asset("assets/images/logo.png", height: 120),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      otpLength,
                      (index) => _buildOtpBox(index),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          (isOtpFilled && !isLoading) ? _submitOtp : () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isOtpFilled ? AppColors.goldColor : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child:
                          isLoading
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              ) // Loader for OTP verification
                              : Text(
                                AppStrings.verify_otp,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap:
                        isResendEmailLoading
                            ? null
                            : () {
                              setState(() {
                                isResendEmailLoading = true; // Show resend loader
                              });
                              _resendEmailCode(context);
                            },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child:
                          isResendEmailLoading
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ) // Loader for Resend button
                              : Text(
                                "Resend Code on email",
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                  InkWell(
                    onTap:
                        isResendPhoneLoading
                            ? null
                            : () {
                              setState(() {
                                isResendPhoneLoading = true; // Show resend loader
                              });
                              _resendPhoneCode(context);
                            },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child:
                          isResendPhoneLoading
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ) // Loader for Resend button
                              : Text(
                                "Resend Code on phone",
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _otpVerify(BuildContext context, String otp) async {
    final otpViewModel = Provider.of<OTPViewModel>(context, listen: false);
    String? accessToken = await SharedPrefHelper().getData<String>(
      "access_token",
    );

    final otpData = {
      "email": Utils.user_email,
      "access_token": accessToken!,
      "otp": otp,
    };

    await otpViewModel.otpVerify(otpData);

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false; // Hide loader after API response
      });
    });

    if (otpViewModel.status == Status.COMPLETE) {
      if (Utils.from_signup) {
        Navigator.pushReplacementNamed(context, RoutesNames.signIn);
      } else {
        Navigator.pushReplacementNamed(context, RoutesNames.home);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(otpViewModel.errorMessage ?? "Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resendEmailCode(BuildContext context) async {
    final otpViewModel = Provider.of<OTPViewModel>(context, listen: false);

    try {
      String? accessToken = await SharedPrefHelper().getData<String>(
        "access_token",
      );
      String? email = await SharedPrefHelper().getData<String>(Utils.user_email);

      if (email == null || accessToken == null) {
        throw Exception("Missing email or access token");
      }

      final otpData = {"email": email, "access_token": accessToken};

      await otpViewModel.resendEmailCode(otpData);

      if (otpViewModel.status == Status.COMPLETE) {
        if(otpViewModel.resend?.success==true){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(otpViewModel.resend?.message ?? "Code not sent"),
              backgroundColor: Colors.green,
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(otpViewModel.resend?.message ?? "Code not sent"), backgroundColor: Colors.red),
          );
        }

      } else {
        throw Exception(otpViewModel.errorMessage ?? "Something went wrong");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isResendEmailLoading = false; // Hide loader after API response
          isResendPhoneLoading = false; // Hide loader after API response
        });
      });
    }
  }


  void _resendPhoneCode(BuildContext context) async {
    final otpViewModel = Provider.of<OTPViewModel>(context, listen: false);

    try {
      String? accessToken = await SharedPrefHelper().getData<String>(
        "access_token",
      );
      String? phone = await SharedPrefHelper().getData<String>(Utils.user_phone);

      if (phone == null || accessToken == null) {
        throw Exception("Missing email or access token");
      }

      final otpData = {"email": phone, "access_token": accessToken};

      await otpViewModel.resendPhoneCode(otpData);

      if (otpViewModel.status == Status.COMPLETE) {
        if(otpViewModel.resend?.success==true){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(otpViewModel.resend?.message ?? "Code not sent"),
              backgroundColor: Colors.green,
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(otpViewModel.resend?.message ?? "Code not sent"), backgroundColor: Colors.red),
          );
        }

      } else {
        throw Exception(otpViewModel.errorMessage ?? "Something went wrong");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isResendEmailLoading = false; // Hide loader after API response
          isResendPhoneLoading = false; // Hide loader after API response
        });
      });
    }
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.goldColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(counterText: "", border: InputBorder.none),
        onChanged: (value) => _onOtpChanged(index, value),
        onSubmitted: (_) => _submitOtp(),
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
      ),
    );
  }
}
