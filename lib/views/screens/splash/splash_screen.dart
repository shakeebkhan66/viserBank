import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/theme/theme_util.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_images.dart';
import 'package:viser_bank/data/controller/localization/localization_controller.dart';
import 'package:viser_bank/data/controller/splash/splash_controller.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';

// class SplashScreen extends StatefulWidget {
//
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//
//     ThemeUtil.makeSplashTheme();
//
//     Get.put(ApiClient(sharedPreferences: Get.find()));
//     Get.put(GeneralSettingRepo(apiClient: Get.find()));
//     Get.put(LocalizationController(sharedPreferences: Get.find()));
//     final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));
//
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.gotoNextPage();
//     });
//   }
//
//   @override
//   void dispose() {
//     ThemeUtil.allScreenTheme();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // Set default language to Italian
//     Locale defaultLocale = const Locale('it', 'IT');
//     // Change the language immediately upon building the widget
//     Get.updateLocale(defaultLocale);
//     return GetBuilder<SplashController>(builder: (controller) => Scaffold(
//       backgroundColor: controller.noInternet?MyColor.colorWhite:MyColor.primaryColor,
//       body: Center(
//         child: Image.asset(MyImages.appLogo, height: Dimensions.appLogoHeight, width: Dimensions.appLogoWidth),
//       ),
//     ));
//   }
// }


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Apply splash screen theme
    ThemeUtil.makeSplashTheme();

    // Initialize dependencies using Get.put
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));

    // Initialize SplashController and move to next screen logic
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    // Restore default theme
    ThemeUtil.allScreenTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set default language to Italian
    Locale defaultLocale = const Locale('it', 'IT');
    // Change the language immediately upon building the widget
    Get.updateLocale(defaultLocale);

    return AnimatedSplashScreen(
      splash: Image.asset(MyImages.appLogo, height: Dimensions.appLogoHeight, width: Dimensions.appLogoWidth),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: MyColor.primaryColor,
      nextScreen: GetBuilder<SplashController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.primaryColor,
          body: Center(
            child: Image.asset(MyImages.appLogo, height: Dimensions.appLogoHeight, width: Dimensions.appLogoWidth),
          ),
        ),
      ),
      duration: 3000,
    );
  }
}

