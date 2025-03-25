import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/core/utils/constants/strings.dart';
import 'package:dream_al_emarat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/routes_names.dart';
import '../viewmodels/setting_view_model.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Fetch settings data when the screen is initialized
    final settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);

  }

  List<Map<String, dynamic>> onboardingData = [];
  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(microseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, RoutesNames.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {

    final settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);
    final settingsResponse = settingsViewModel.settings;

    onboardingData = [
      {
        "image": "assets/images/onboarding_image_1.png",
        "title": settingsResponse?.data?.onBoardingText?.first?.title ?? "Sign Up",
        "subtitle": List<String>.from(settingsResponse?.data?.onBoardingText?.first?.description ?? []),
      },
      {
        "image": "assets/images/onboarding_image_2.png",
        "title": settingsResponse?.data?.onBoardingText?.second?.title ?? "Buy Gold",
        "subtitle": List<String>.from(settingsResponse?.data?.onBoardingText?.second?.description ?? []),
      },
      {
        "image": "assets/images/onboarding_image_3.png",
        "title": settingsResponse?.data?.onBoardingText?.third?.title ?? "Sell Gold",
        "subtitle": List<String>.from(settingsResponse?.data?.onBoardingText?.third?.description ?? []),
      },
      {
        "image": "assets/images/onboarding_image_4.png",
        "title": settingsResponse?.data?.onBoardingText?.fourth?.title ?? "Earn Profit",
        "subtitle": List<String>.from(settingsResponse?.data?.onBoardingText?.fourth?.description ?? []),
      },
    ];

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
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder:
                        (context, index) => OnboardingContent(
                          image: onboardingData[index]["image"]!,
                          title: onboardingData[index]["title"]!,
                          subtitle:  List<String>.from(onboardingData[index]["subtitle"] ?? []),
                        ),
                  ),
                ),
                //Bottom Selection: Skip | Dots Indicator | Next Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Skip Button
                      //_currentPage != onboardingData.length - 1
                      TextButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, RoutesNames.signIn);} ,
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //: SizedBox(width: 60),
                      // Page Indicator Dots
                      Row(
                        children: List.generate(
                          onboardingData.length,
                          (index) => buildDot(index),
                        ),
                      ),

                      // Next Button
                      TextButton(
                        onPressed: _nextPage,
                        child: Text(
                          _currentPage == onboardingData.length - 1
                              ? "Finish"
                              : "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.goldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Page Indicator Dots
  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: _currentPage == index ? 10 : 8,
      height: _currentPage == index ? 10 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.goldColor : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title;
  final List<String> subtitle;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 200, width: 200),
        SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.goldColor,
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: subtitle.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 16.0), // Add left padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10), // Add spacing before the bullet point
                    Text(
                      "• ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}



