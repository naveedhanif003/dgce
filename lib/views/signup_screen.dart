import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/routes/routes_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utils/Utils.dart';
import '../core/utils/dialogs/showCustomDialog.dart';
import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../core/utils/widgets/PhoneNumberField.dart';
import '../core/utils/widgets/buildInputField.dart';
import '../viewmodels/setting_view_model.dart';
import '../viewmodels/signup_view_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+1";
  String selectedCountry = "USA";
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
    final settingsViewModel = Provider.of<SettingsViewModel>(
      context,
      listen: false,
    );
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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

                          children: [
                            SizedBox(height: 20),
                            Center(
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: 120,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              AppStrings.signUp,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              AppStrings.signup_des,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            buildInputField(
                              label: AppStrings.first_name,
                              controller: firstName,
                              validator:
                                  (value) =>
                                      value!.isEmpty
                                          ? "Enter first name"
                                          : null,
                            ),
                            SizedBox(height: 10),
                            buildInputField(
                              label: AppStrings.last_name,
                              controller: lastName,
                              validator:
                                  (value) =>
                                      value!.isEmpty ? "Enter last name" : null,
                            ),
                            SizedBox(height: 10),
                            buildInputField(
                              label: AppStrings.email,
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              controller: email,
                              validator: (value) => Utils.validateEmail(value),
                            ),
                            SizedBox(height: 10),
                            PhoneNumberField(
                              controller: phoneController,
                              selectedCountryCode: "+1", // Default code
                              onCountryChanged: (
                                String countryName,
                                String countryCode,
                              ) {
                                selectedCountryCode = countryCode;
                                selectedCountry = countryName;
                                print("Selected Country: $countryName");
                                print("Selected Code: $countryCode");
                              },
                            ),
                            SizedBox(height: 10),
                            buildInputField(
                              label: AppStrings.password,
                              icon: Icons.lock,
                              isPassword: true,
                              inputType: TextInputType.visiblePassword,
                              controller: password,
                              validator:
                                  (value) => Utils.validatePassword(value),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                  icon: Icon(
                                    _isChecked
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: AppColors.goldColor,
                                  ),
                                ),
                                Text(
                                  "Accept the ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchUrl(
                                      "https://test.dhinvest.ae/term-condition?is_httpClient=1",
                                    );
                                  },
                                  child: Text(
                                    "Terms&Condition",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  " and ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchUrl(
                                      "https://test.dhinvest.ae/privacy-policy?is_httpClient=1",
                                    );
                                  },
                                  child: Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   child: Text(
                                //     AppStrings.terms_and_conditions,
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 10,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    signUpViewModel.status == Status.LOADING
                                        ? null
                                        : () => _signUp(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.goldColor,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child:
                                    signUpViewModel.status == Status.LOADING
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : Text(
                                          AppStrings.signUp,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text: AppStrings.already_account,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppStrings.signIn,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldColor,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              RoutesNames.signIn,
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     InkWell(
                            //       onTap: () {
                            //         _launchUrl("https://test.dhinvest.ae/term-condition?is_httpClient=1");
                            //       },
                            //       child: Text(
                            //         "Terms&Condition",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           decoration: TextDecoration.underline,
                            //           decorationColor: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //     Text("/",style: TextStyle(color: Colors.white),),
                            //     InkWell(
                            //       onTap: () {
                            //         _launchUrl("https://test.dhinvest.ae/privacy-policy?is_httpClient=1");
                            //       },
                            //       child: Text(
                            //         "Privacy Policy",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           decoration: TextDecoration.underline,
                            //           decorationColor: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (!_isChecked) {
        Utils.Custom_SnackBar(
          "Please agree to the terms and conditions",
          context,
          Colors.red,
        );
        return;
      }
      String? fcmToken = await SharedPrefHelper().getData<String>("fcm_token");
      final signUpViewModel = Provider.of<SignUpViewModel>(
        context,
        listen: false,
      );
      final signup = {
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "password": password.text,
        "user_role_name": "customer",
        "fcm_token": fcmToken ?? "",
        "phone": phoneController.text,
        "country": selectedCountry,
        "dial_code": selectedCountryCode,
      };
      await signUpViewModel.fetchSignup(signup);

      print(
        "data: $signup \n  response: ${signUpViewModel.signup?.message}  \n status: ${signUpViewModel.status}",
      );

      if (signUpViewModel.status == Status.COMPLETE &&
          signUpViewModel.signup?.success == true) {
        await SharedPrefHelper().saveData<String>(
          "access_token",
          signUpViewModel.signup?.data?.accessToken ?? "",
        );
        await SharedPrefHelper().saveData<String>(
          Utils.user_email,
          email.text.toString(),
        );
        await SharedPrefHelper().saveData<String>(
          Utils.user_phone,
          "${selectedCountryCode}${phoneController.text}",
        );
        showCustomDialog(
          context: context,
          title: "Verify Account",
          message:
              "${signUpViewModel.signup?.message}\nVerification Code Sent to your given email.",
          icon: Icons.verified_user,
          positiveText: "OK",
          onPositivePressed: () {
            Navigator.pop(context);
            Utils.from_signup = true;
            Navigator.pushReplacementNamed(context, RoutesNames.otpPassword);
          },
        );

        //_navigateToNextScreen(HomeScreen()); // Navigate on success
      } else {
        showCustomDialog(
          context: context,
          title: "Alert",
          message: "${signUpViewModel.signup?.message}",
          icon: Icons.error,
          positiveText: "Ok",
          onPositivePressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  Future<void> _launchUrl(urlString) async {
    print(urlString);
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
