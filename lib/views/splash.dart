import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:dream_al_emarat_app/core/utils/Utils.dart';
import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/dialogs/showCustomDialog.dart';
import 'package:dream_al_emarat_app/routes/routes_names.dart';
import 'package:dream_al_emarat_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../viewmodels/setting_view_model.dart';
import 'onBoardingScreens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay API call until the widget tree is stable
    Future.microtask(() => _loadSettings());
  }

  void _loadSettings() async {
    final settingsViewModel = Provider.of<SettingsViewModel>(
      context,
      listen: false,
    );
    String? accessToken = await SharedPrefHelper().getData<String>(
      "access_token",
    );
    String? fcmToken = await SharedPrefHelper().getData<String>("fcm_token");
    final params = {
      "fcm_token": fcmToken ?? "fcm_token not found",
      "user_type": "customer",
      "fcm_token_type": "customer", // nullable, in:customer,guest
      "access_token": accessToken ?? "",
    };
    await settingsViewModel.fetchSettings(params);


    print(
      "API Response: ${settingsViewModel.settings?.message}    ${settingsViewModel.settings?.data?.isAccessTokenValid!}",
    );
    if (settingsViewModel.status == Status.ERROR) {
      showCustomDialog(
        context: context,
        message: settingsViewModel.errorMessage!!,
      );
      print("Setting Error Message ${settingsViewModel.errorMessage}");
    }

    checkOnboarding(context, settingsViewModel.settings!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/splash_background.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "DGCE FOR GOLD & PRECIOUS METAL",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),Text(
                    "PRODUCTS MANUFACTURING CO.L.L.C",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // settingsViewModel.status == Status.LOADING
              //     ? CircularProgressIndicator(color: Colors.white)
              //     : ,
            ),
          ],
        ),
      ),
    );
  }

  void checkOnboarding(BuildContext context, SettingApiResponse setting) async {
    bool? isOnboardingAlreadyShow = await SharedPrefHelper().getData<bool>(
      "isOnboardingAlreadyShow",
    );

    print("isOnboardingAlreadyShow: $isOnboardingAlreadyShow");

    Future.delayed(Duration(seconds: 3), () async {
      if (context.mounted) {
        // Ensure widget is still in the tree
        if (isOnboardingAlreadyShow == null || !isOnboardingAlreadyShow) {
          await SharedPrefHelper().saveData<bool>(
            "isOnboardingAlreadyShow",
            true,
          );
          Navigator.pushReplacementNamed(
            context,
            RoutesNames.onBoardingScreens,
          );
        } else {
          if (setting.data?.isAccessTokenValid != true ||
              setting.data?.isEmailVerified != true) {
            Navigator.pushReplacementNamed(context, RoutesNames.signIn);
          } else {
            Navigator.pushReplacementNamed(context, RoutesNames.home);
          }
        }
      }
    });
  }
}
