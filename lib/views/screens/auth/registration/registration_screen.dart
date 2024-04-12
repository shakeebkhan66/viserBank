import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/auth/auth/registration_controller.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/data/repo/auth/signup_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/auth/registration/widget/registration_form.dart';

import '../../../../core/utils/my_strings.dart';
import '../login/widget/bottom_section.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor2(),
            // appBar: const CustomAppBar(title: MyStrings.signUp,fromAuth: true,),
            body: controller.isLoading ? const CustomLoader() : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: MyColor.primaryColor,
                          gradient: LinearGradient(
                            colors: [
                              MyColor.primaryColor,
                              MyColor.titleColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(250.0))
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(MyStrings.signUpTitle.tr, style: interSemiBoldExtraLarge.copyWith(fontSize:Dimensions.fontHeader2,fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Padding(
                    // padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.2),
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(MyStrings.signUpSologanNew.tr, textAlign: TextAlign.left,style: interRegularDefault.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: Dimensions.space20),
                  const RegistrationForm(),
                  const BottomSectionSignUp(),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.privacyScreen);
                    },
                    child: Text("Privacy e politiche".toLowerCase(),  style: const TextStyle(color: MyColor.titleColor),),
                  ),
                  ],
                ),
            ),
            )
          ),
      ),
      );
  }
}
