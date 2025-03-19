import 'dart:convert';

import 'package:dream_al_emarat_app/core/utils/Utils.dart';
import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/routes/routes_names.dart';
import 'package:dream_al_emarat_app/views/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../core/utils/widgets/buildInputField.dart';
import '../viewmodels/login_view_model.dart';
import '../viewmodels/setting_view_model.dart';
import 'HomeScreen.dart';
import 'forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    // Logo
                    Center(
                      child: Image.asset("assets/images/logo.png", height: 120),
                    ),
                    SizedBox(height: 20),
                    // Title
                    Text(
                      AppStrings.signIn,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Description
                    Text(
                      AppStrings.signDes,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: 30),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildInputField(
                              label: "Email",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              controller: email,
                              validator: (value) => Utils.validateEmail(value),
                            ),
                            SizedBox(height: 20),
                            buildInputField(
                              label: "Password",
                              icon: Icons.lock,
                              isPassword: true,
                              inputType: TextInputType.visiblePassword,
                              controller: password,
                              validator:
                                  (value) => Utils.validatePassword(value),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    loginViewModel.status == Status.LOADING
                                        ? null // Disable button while loading
                                        : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // **Validate before API call**
                                            _login(context);
                                          }
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.goldColor,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child:
                                    loginViewModel.status == Status.LOADING
                                        ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                        : Text(
                                          AppStrings.signIn,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesNames.forgotScreen,
                                );
                                // _navigateToNextScreen(ForgetPassScreen());
                              },
                              child: Text(
                                AppStrings.forgot_pass,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.goldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    // Bottom Signup Text
                    Text.rich(
                      TextSpan(
                        text: AppStrings.open_account,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        children: [
                          TextSpan(
                            text: AppStrings.signup_account,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldColor,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RoutesNames.signUp,
                                    );
                                    // _navigateToNextScreen(SignUpScreen());
                                  },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Login API Call**
  void _login(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    String? fcmToken = await SharedPrefHelper().getData<String>(
      "fcm_token",
    );
    final loginData = {
      "email": email.text.trim(),
      "password": password.text.trim(),
      "user_role_name": "customer",
      "fcm_token":
      fcmToken?? "",
      "device_id": "@34",
    };

    await loginViewModel.fetchLogin(loginData);

    if (loginViewModel.status == Status.COMPLETE) {
      if(loginViewModel.login?.success==true) {
        await SharedPrefHelper().saveData<String>(
          "access_token",
          loginViewModel.login?.data?.accessToken ?? "",
        );

        await SharedPrefHelper().saveData<String>(
          "login_response",
          jsonEncode(loginViewModel.login?.toJson()), // Convert response to JSON string
        );

        if (loginViewModel.login?.data?.isEmailVerified ?? false) {
          print("login access token ${loginViewModel.login?.data?.isEmailVerified}");
          Navigator.pushReplacementNamed(context, RoutesNames.home);
        } else {
          Utils.user_email = email.text.trim();
          await SharedPrefHelper().saveData<String>(
            Utils.user_email,
            Utils.user_email ?? "",
          );
          Navigator.pushReplacementNamed(context, RoutesNames.otpPassword);
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginViewModel.login?.error ?? "Login failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
      //_navigateToNextScreen(HomeScreen()); // Navigate on success
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loginViewModel.errorMessage ?? "Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
