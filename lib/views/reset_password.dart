import 'package:dream_al_emarat_app/apis_response/reset_api_response/ResetApiResponse.dart';
import 'package:dream_al_emarat_app/core/utils/Utils.dart';
import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/viewmodels/reset_pass_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/helpers/status.dart';
import '../core/utils/widgets/buildInputField.dart';
import '../routes/routes_names.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreen createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  TextEditingController code = TextEditingController();
  TextEditingController new_password = TextEditingController();
  TextEditingController re_enter_password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Image.asset("assets/images/logo.png", height: 120),
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppStrings.reset_password,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldColor,
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Consumer<ResetViewModel>(
                          builder: (context, resetViewModel, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildInputField(
                                  label: AppStrings.verification_code,
                                  inputType: TextInputType.text,
                                  controller: code,
                                  validator:
                                      (value) => Utils.validateCode(value),
                                ),
                                SizedBox(height: 20),
                                buildInputField(
                                  label: AppStrings.new_password,
                                  icon: Icons.lock,
                                  isPassword: true,
                                  inputType: TextInputType.visiblePassword,
                                  controller: new_password,
                                  validator:
                                      (value) => Utils.validatePassword(value),
                                ),
                                SizedBox(height: 20),
                                buildInputField(
                                  label: AppStrings.re_enter_password,
                                  icon: Icons.lock,
                                  isPassword: true,
                                  inputType: TextInputType.visiblePassword,
                                  controller: re_enter_password,
                                  validator:
                                      (value) => Utils.validateMatchPassword(
                                        value,
                                        new_password.text,
                                      ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        resetViewModel.status == Status.LOADING
                                            ? null
                                            : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _resendPassword(context);
                                              }
                                            },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.goldColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child:
                                        resetViewModel.status == Status.LOADING
                                            ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                            : Text(
                                              AppStrings.reset_password,
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
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RoutesNames.signIn,
                                    );
                                  },
                                  child: Text(
                                    "Go to Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration:
                                          TextDecoration
                                              .underline, // Optional for styling
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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

  void _resendPassword(BuildContext context) async {
    final resetViewModel = Provider.of<ResetViewModel>(context, listen: false);

    try {
      final otpData = {
        "reset_code": code.text,
        "password": new_password.text,
        "password_confirmation": re_enter_password.text,
      };

      await resetViewModel.resetPass(otpData);

      if (resetViewModel.status == Status.COMPLETE) {
        if (resetViewModel.reset?.success == true) {
          Navigator.pushReplacementNamed(context, RoutesNames.signIn);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resetViewModel.reset?.message ?? "Password not reset",
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception(resetViewModel.errorMessage ?? "Something went wrong");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      Future.delayed(Duration(milliseconds: 500), () {});
    }
  }
}
