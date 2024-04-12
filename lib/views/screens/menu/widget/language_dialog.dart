import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/data/model/language/language_model.dart';
import 'package:viser_bank/data/model/language/main_language_response_model.dart';
import 'package:viser_bank/views/screens/menu/widget/language_dialog_body.dart';


void showLanguageDialog(String languageList,Locale selectedLocal,BuildContext context,{bool fromSplash = false}){
  var language = jsonDecode(languageList);
  MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(language);
 
  List<LanguageModel>langList = [];

  if(model.data?.languages !=null && model.data!.languages!.isNotEmpty){
    for (var listItem in model.data!.languages!) {
      LanguageModel model = LanguageModel(imageUrl:listItem.icon??'',languageCode: listItem.code??'', countryCode: listItem.name??'', languageName: listItem.name??'');
      langList.add(model);
    }
  }
  
  showDialog(context: context, builder: (BuildContext context){
    return  AlertDialog(
      backgroundColor: Colors.cyan.shade100,
      content: LanguageDialogBody(langList:langList,fromSplashScreen: fromSplash,),
    );
  });


}