import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_images.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/auth/login_controller.dart';
import 'package:viser_bank/data/controller/common/theme_controller.dart';
import 'package:viser_bank/data/controller/home/home_controller.dart';
import 'package:viser_bank/data/controller/menu_/menu_controller.dart' as menu;
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/data/repo/auth/login_repo.dart';
import 'package:viser_bank/data/repo/home/home_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:viser_bank/views/components/divider/custom_divider.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/add_my_bank_beneficiary_bottom_sheet.dart';
import 'package:viser_bank/views/screens/transfer/pay_with_%25.dart';

import '../../../../data/controller/localization/localization_controller.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import 'widget/language_dialog.dart';
import 'widget/menu_card.dart';
import 'widget/menu_row_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  HomeController controller =
      Get.put(HomeController(repo: Get.put(HomeRepo(apiClient: Get.find()))));

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(menu.MenuController(repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetBuilder<menu.MenuController>(
          builder: (menuController) => WillPopWidget(
                nextRoute: RouteHelper.homeScreen,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: MyColor.getScreenBgColor1(),
                    // appBar: CustomAppBar(
                    //     title: MyStrings.menu.tr,
                    //     isShowBackBtn: false,
                    //     isShowActionBtn: false,
                    //     bgColor: MyColor.getAppbarBgColor(),
                    // ),
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        child: AppBar(
                          title: Center(
                            child: Text(
                              MyStrings.menu.tr,
                              style: interRegularLarge.copyWith(color: MyColor.colorWhite),
                            ),
                          ),
                          backgroundColor: MyColor.primaryColor.withOpacity(0.8),
                          elevation: 0,
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Il mio profilo",
                            style: TextStyle(
                                color: MyColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.profile,
                                  label: "Il mio profilo",
                                  onPressed: () =>
                                      Get.toNamed(RouteHelper.profileScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.changePass,
                                  label: MyStrings.changePassword.tr,
                                  onPressed: () => Get.toNamed(
                                      RouteHelper.changePasswordScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.referral,
                                  label: MyStrings.referral.tr,
                                  onPressed: () =>
                                      Get.toNamed(RouteHelper.referralScreen),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.space12),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            "Generale",
                            style: TextStyle(
                                color: MyColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.deposit,
                                  label: 'Payment Request',
                                  onPressed: () {
                                    Get.to(const PaymentWithPercentage());
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.notificationIcon,
                                  label: MyStrings.notification.tr,
                                  onPressed: () => Get.toNamed(
                                      RouteHelper.notificationScreen),
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                Visibility(
                                    visible: menuController.isDepositEnable,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MenuRowWidget(
                                          image: MyImages.deposit,
                                          label: MyStrings.deposit.tr,
                                          onPressed: () => Get.toNamed(
                                              RouteHelper.depositsScreen),
                                        ),
                                        const CustomDivider(
                                            space: Dimensions.space15),
                                      ],
                                    )),
                                if (controller.userType == 'agent')
                                  Visibility(
                                      visible: menuController.isWithdrawEnable,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MenuRowWidget(
                                            image: MyImages.withdrawIcon,
                                            label: MyStrings.withdraw.tr,
                                            onPressed: () => Get.toNamed(
                                                RouteHelper.withdrawScreen),
                                          ),
                                          const CustomDivider(
                                              space: Dimensions.space15),
                                        ],
                                      )),
                                Visibility(
                                    visible: menuController.langSwitchEnable,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MenuRowWidget(
                                          image: MyImages.language,
                                          label: MyStrings.language.tr,
                                          onPressed: () {
                                            final apiClient = Get.put(ApiClient(
                                                sharedPreferences: Get.find()));
                                            SharedPreferences pref =
                                                apiClient.sharedPreferences;
                                            String language = pref.getString(
                                                    SharedPreferenceHelper
                                                        .languageListKey) ??
                                                '';
                                            String countryCode = pref.getString(
                                                    SharedPreferenceHelper
                                                        .countryCode) ??
                                                'US';
                                            String languageCode =
                                                pref.getString(
                                                        SharedPreferenceHelper
                                                            .languageCode) ??
                                                    'en';
                                            log(countryCode.toString());
                                            Locale local = Locale(
                                                languageCode, countryCode);
                                            showLanguageDialog(
                                                language, local, context);
                                            //Get.toNamed(RouteHelper.languageScreen);
                                          },
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.space12),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            "Altri",
                            style: TextStyle(
                                color: MyColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          MenuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.termsAndCon,
                                  label: MyStrings.terms.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.privacyScreen);
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  image: MyImages.faq,
                                  label: MyStrings.faq.tr,
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.faqScreen);
                                  },
                                ),
                                const CustomDivider(space: Dimensions.space15),
                                MenuRowWidget(
                                  isLoading: menuController.logoutLoading,
                                  image: MyImages.signOut,
                                  label: MyStrings.signOut.tr,
                                  onPressed: () {
                                    menuController.logout();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
                  ),
                ),
              ));
    });
  }
}
