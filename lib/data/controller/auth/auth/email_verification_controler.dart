import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/data/model/authorization/authorization_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/repo/auth/sms_email_verification_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';

class EmailVerificationController extends GetxController {


  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});


  String currentText = "";
  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;

  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = false;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading = false;
    update();
  }


  Future<void> verifyEmail(String text) async {

    if (text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg],);
      return;
    }

    submitLoading=true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {



          if(needSmsVerification){
            Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable,needTwoFactor]);
          } else if(needTwoFactor){
            Get.offAndToNamed(RouteHelper.twoFactorVerificationScreen,arguments: isProfileCompleteEnable);
          }
          else{
            Get.offAndToNamed(isProfileCompleteEnable?
            RouteHelper.profileCompleteScreen : RouteHelper.homeScreen,);
          }

          CustomSnackBar.success(successList: model.message?.success??[(MyStrings.emailVerificationSuccess.tr)]);

      } else {
         CustomSnackBar.error(errorList: model.message?.error??[(MyStrings.emailVerificationFailed.tr)] ,);
        }
    }
    else {
        CustomSnackBar.error(errorList: [responseModel.message.tr] ,);
    }

    submitLoading=false;
    update();

  }



  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }




}
