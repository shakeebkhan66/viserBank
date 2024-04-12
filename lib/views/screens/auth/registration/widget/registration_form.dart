import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/auth/auth/registration_controller.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/text-field/custom_text_field.dart';
import 'package:viser_bank/views/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:viser_bank/views/screens/auth/registration/widget/country_text_field.dart';
import 'package:viser_bank/views/screens/auth/reset_password/widget/validation_widget.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                needLabel: true,
                labelText: "Nome utente",
                // hintText: MyStrings.enterYourUsername.tr,
                hintText: 'Inserisci il tuo nome utente',
                controller: controller.userNameController,
                focusNode: controller.userNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourUsername.tr;
                  } else if(value.length<6){
                    return MyStrings.kShortUserNameError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
              CustomTextField(
                needLabel: true,
                labelText: "E-mail",
                // hintText: MyStrings.enterYourEmail.tr,
                hintText: 'Inserisci il tuo indirizzo email',
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                    return MyStrings.invalidEmailMsg.tr;
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
              CountryTextField(
                press: (){
                  CountryBottomSheet.bottomSheet(context, controller);
                },
                text:controller.countryName == null?MyStrings.selectACountry.tr:(controller.countryName)!.tr,
              ),
              const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:CustomTextField(
                      // labelText: MyStrings.phone,
                      labelText: "Telefono",
                      controller: TextEditingController(text: controller.mobileCode??''),
                      textInputType: TextInputType.phone,
                      disableColor: controller.hasMobileFocus?MyColor.primaryColor:MyColor.borderColor,
                      isEnable: false,
                      onChanged: (value) {
                        return;
                      },
                    ),),
                  const SizedBox(width: 8,),
                  Expanded(
                      flex: 6,
                      child: Focus(
                        onFocusChange: (hasFocus){
                          controller.changeMobileFocus(hasFocus);
                        },
                        child:  CustomTextField(
                          // labelText: MyStrings.enterYourPhoneNumber.tr,
                          labelText: "Inserisci il tuo numero di telefono",
                          // hintText: MyStrings.enterYourPhoneNo.tr,
                          hintText: "Inserisci il tuo numero di telefono",
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          textInputType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          onChanged: (value) {
                            return;
                          },
                          validator: (value){
                            if(value.toString().isEmpty){
                              return MyStrings.enterYourPhoneNumber.tr;
                            }
                            return null;
                          },
                        ),
                      )),
                ],
              ),

              const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
              Visibility(
                  visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                  child: ValidationWidget(fromReset: true,list: controller.passwordValidationRulse,)),
              Focus(
                  onFocusChange: (hasFocus){
                    controller.changePasswordFocus(hasFocus);
                  },
                  child: CustomTextField(
                    isShowSuffixIcon: true,
                    isPassword: true,
                    // labelText: "Enter your password",
                    labelText: "Parola d'ordine",
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPasswordFocusNode,
                    // hintText: MyStrings.enterYourPassword.tr,
                    hintText: "Inserisci la tua password",
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      if(controller.checkPasswordStrength){
                        controller.updateValidationList(value);
                      }
                    },
                    validator: (value) {
                      return controller.validatPassword(value ?? '');
                    },
                  )),
              const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
              CustomTextField(
                // labelText: "Confirm password",
                labelText: "Conferma password",
                // hintText: MyStrings.confirmYourPassword.tr,
                hintText: "Conferma password",
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isShowSuffixIcon: true,
                isPassword: true,
                onChanged: (value) {},
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              Visibility(
                  visible: controller.needAgree,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            activeColor: MyColor.primaryColor,
                            value: controller.agreeTC,
                            side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                width: 1.0,
                                color: controller.agreeTC ? MyColor.transparentColor : MyColor.colorGrey),
                            ),
                            onChanged: (value) {
                              controller.updateAgreeTC();
                            }
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Row(
                        children: [
                          Text(MyStrings.iAgreeWith.tr, style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                          const SizedBox(width: 3),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: Dimensions.space12),
              controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                  text: MyStrings.signUp,
                  textColor: MyColor.colorWhite,
                  color: MyColor.primaryColor,
                  press: (){
                    if (formKey.currentState!.validate()) {
                      controller.signUpUser();
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}