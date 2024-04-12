import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/auth/login_controller.dart';
import 'package:viser_bank/data/repo/auth/login_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/auth/login/widget/login_form.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool b = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(LoginController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.remember = false;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColor.backgroundColor,
              resizeToAvoidBottomInset: false,
              body: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(height: 30),
                    Text(MyStrings.loginTitle.tr, style: interRegularDefault.copyWith(fontSize:Dimensions.fontHeader2,fontWeight: FontWeight.w600)),
                    const SizedBox(height: 15),
                    Padding(
                      padding:EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.0),
                      child: Text(MyStrings.loginSologan.tr, textAlign: TextAlign.left,style: interRegularDefault.copyWith(color: MyColor.getGreyText()),)
                    ),
                    const SizedBox(height: Dimensions.space50),
                    const LoginForm()
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
}
