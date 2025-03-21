import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/views/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/Utils.dart';
import '../core/utils/dialogs/showCustomDialog.dart';
import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../core/utils/widgets/buildInputField.dart';
import '../routes/routes_names.dart';
import '../viewmodels/forgot_view_model.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreen createState() => _ForgetPassScreen();
}

class _ForgetPassScreen extends State<ForgetPassScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPasswordField = false;

  @override
  Widget build(BuildContext context) {
    final forgotViewModel = Provider.of<ForgotViewModel>(context);
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
                    SizedBox(height: 80),
                    // Logo
                    Center(
                      child: Image.asset("assets/images/logo.png", height: 120),
                    ),
                    SizedBox(height: 20),
                    // Title
                    Text(
                      AppStrings.forgot_pass,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Description
                    Text(
                      AppStrings.enter_email,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: 30),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: !showPasswordField,
                              child: buildInputField(
                                label: AppStrings.email,
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                controller: email,
                                validator:
                                    (value) => Utils.validateEmail(value),
                              ),
                            ),
                            Visibility(
                              visible: showPasswordField,
                              child: SizedBox(height: 20),
                            ),
                            Visibility(
                              visible: showPasswordField,
                              child: buildInputField(
                                label: "Password",
                                icon: Icons.lock,
                                isPassword: true,
                                inputType: TextInputType.visiblePassword,
                                controller: password,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    forgotViewModel.status == Status.LOADING
                                        ? null // Disable button while loading
                                        : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // **Validate before API call**
                                            _forgot(context);
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
                                    forgotViewModel.status == Status.LOADING
                                        ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                        : Text(
                                          AppStrings.send,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }

  /// **Forgot API Call**
  void _forgot(BuildContext context) async {
    final forgotViewModel = Provider.of<ForgotViewModel>(
      context,
      listen: false,
    );
    final forgotData = {"email": email.text.trim()};
    print("forgotData ${forgotData}");
    await forgotViewModel.fetchForgot(forgotData);
    print("forgot api response ${forgotViewModel.forgot}");
    if (forgotViewModel.status == Status.COMPLETE) {
      if (forgotViewModel.forgot?.success == 0) {
        showCustomDialog(
          context: context,
          title: "Alert",
          message: "${forgotViewModel.forgot?.message}",
          icon: Icons.error,
          positiveText: "Ok",
          onPositivePressed: () {
            Navigator.pop(context);
          },
        );
      } else {
        showCustomDialog(
          context: context,
          title: "Alert",
          message: "${forgotViewModel.forgot?.message}",
          icon: Icons.add_alert,
          positiveText: "Ok",
          onPositivePressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutesNames.resetPassword);
          },
        );
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(forgotViewModel.errorMessage ?? "Forgot failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
