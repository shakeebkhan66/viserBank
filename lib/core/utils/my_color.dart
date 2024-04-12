import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controller/common/theme_controller.dart';

class MyColor{

  static const Color lScreenBgColor1 = Color(0xfff5f6fa);
  static const Color cyanColor = Colors.cyan;
  static const Color navigationBarColor = Color(0xffd7d9da);
  static const Color lPrimaryColor = Color(0xff1F2B3A);
  static const Color appBarColor = primaryColor;
  static const Color cardBgColor = Color(0xff192D36);
  static const Color fieldDisableBorderColor = Color(0xff2C3F47);

  static Color getLabelTextColor(){
    return labelTextColor;
  }

  static Color getHintTextColor(){
    return Get.find<ThemeController>().darkTheme ? hintTextColor : hintTextColor;
  }

  static Color getButtonColor(){
    return  primaryColor ;
  }

  static Color getButtonTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlack : colorWhite;
  }

  static Color getPrimaryColor(){
    return  primaryColor ;
  }

  static Color getAppbarBgColor() {
    return Get.find<ThemeController>().darkTheme ? appBarColor : appBarColor;
  }

  static Color getScreenBgColor2(){
    return Get.find<ThemeController>().darkTheme ?colorWhite:colorWhite;
  }

  static Color getScreenBgColor(){
    return Get.find<ThemeController>().darkTheme ?backgroundColor:backgroundColor;
  }
  static Color getScreenBgColor1(){
    return Get.find<ThemeController>().darkTheme ? lScreenBgColor1 : lScreenBgColor1;
  }

  static Color getCardBg(){
    return Get.find<ThemeController>().darkTheme ? cardBgColor : lScreenBgColor1;
  }
  static Color getCardBg1(){
    return Get.find<ThemeController>().darkTheme ? cardBgColor : bgColor1;
  }


  static Color getTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorBlack:colorBlack ;
  }

  static Color getPrimaryTextColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorBlack;
  }



  static Color getDialogBg(){
    return Get.find<ThemeController>().darkTheme ? cardBgColor :   bgColorLight;
  }

  static Color getGreyText(){
    return Get.find<ThemeController>().darkTheme ? MyColor.colorBlack.withOpacity(0.5) :  MyColor.colorBlack.withOpacity(0.5);
  }

  static Color getGreyText1(){
    return Get.find<ThemeController>().darkTheme ? MyColor.colorBlack.withOpacity(0.8) :  MyColor.colorBlack.withOpacity(0.8);
  }

  static Color getFieldDisableBorderColor(){
    return Get.find<ThemeController>().darkTheme ? fieldDisableBorderColor : colorGrey.withOpacity(0.3);
  }

  static Color getTextColor2(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorGrey;
  }

  static Color getUnselectedIconColor(){
    return Get.find<ThemeController>().darkTheme ? colorWhite : colorGrey.withOpacity(0.6);
  }

  static Color getBorderColor(){
    return Get.find<ThemeController>().darkTheme ? lineColor : titleColor;
  }

  static Color getBodyTextColor(){
    return Get.find<ThemeController>().darkTheme ? Colors.grey.withOpacity(.3) : bodyTextColor;
  }


  static const Color primaryColor           = Color(0xff3D5666);
  static const Color green                  = Color(0xff2ECC06);
  static const Color secondaryColor         = Color(0xffFFFFFF);
  static const Color containerBgColor       = Color(0xffF9F9F9);
  static const Color imageContainerBg       = Color(0xffE0E4FC);

  static Color primaryColor600              = primaryColor.withOpacity(0.1);
  static const Color titleColor = Color(0xff373e4a);
  static const Color lineColor = Color(0xffECECEC);
  static const Color labelTextColor = Color(0xff444444);
  static const Color smallTextColor1 = Color(0xff555555);
  static const Color smallTextColor2 = Color(0xff777777);
  static const Color primaryColor900 = Color(0xffE0EAFB);

  static const Color backgroundColor = Color(0xffF9F9F9);
  static const Color textColor =  Color(0xffFFFFFF);
  static const Color hintTextColor = Color(0xff44555B);
  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);

  static const Color colorBlack = Color(0xff262626);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorGrey  = Color(0xFFA0A4A8);
  static const Color colorGrey2 = Color(0xFF6E6E6E);
  static const Color bodyTextColor = Color(0xFF747475);
  static  Color transparentColor = Colors.transparent;

  static const Color colorBlack2 = Color(0xff25282B);
  static const Color colorGrey1 = Color(0xffF8F8F8);
  static const Color borderColor=Color(0xFFEFEFEF);

  static const Color highPriorityPurpleColor=Color(0xFF7367F0);
  static const bgColorLight = Color(0xFFf2f2f2);
  static const bgColor1 = Color(0xFFF9F9F9);

  static const Color greenSuccessColor=greenP;
  static const Color redCancelTextColor=Color(0xFFF93E2C);
  static const Color colorRed = Color(0xffea5455);
  static const Color pendingColor = Colors.orange;

  static const Color red= Color(0xFFD92027);
  static const Color greenP= Color(0xFF28C76F);

  static Color getTextFieldDisableBorder(){
    return textFieldDisableBorderColor;
  }

  static List<Color>colorPlate = [
      primaryColor,
      const Color(0xFF00008B),
      const Color(0xFF77349b),
      const Color(0xFF0069aa),
      const Color(0xFF150f82),
      const Color(0xFFf72060),
      const Color(0xFF483D8B),
      const Color(0xFFF0E68C),
      const Color(0xFF228B22),
  ];

}