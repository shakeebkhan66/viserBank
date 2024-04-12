import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/model/authorized/deposit/deposit_insert_method.dart';
import 'package:viser_bank/data/model/authorized/deposit/deposit_insert_response_model.dart';
import 'package:viser_bank/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:viser_bank/data/model/general_setting/general_settings_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';
import 'package:viser_bank/views/screens/deposits/new_deposit/deposit_model.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/search_api_model.dart';
import 'package:http/http.dart' as http;

import '../../repo/deposit/deposit_repo.dart';

class AddNewDepositController extends GetxController{

  DepositRepo depositRepo;

  AddNewDepositController({required this.depositRepo});

  bool isLoading = true;

  List<Methods> methodList = [];

  String selectedValue = "";

  String depositLimit = "";
  String charge = "";
  String payable = "";
  var amount ;
  String fixedCharge = "";
  String currency = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';
  var selectedNumber;
  var selectedNumber1;
  var methodCodee;
  Methods? paymentMethod =  Methods(name: MyStrings.selectOne,id: -1);


  TextEditingController amountController = TextEditingController();

  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods? method) {
    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    paymentMethod = method;
    depositLimit =
    '${Converter.formatNumber(
        method?.minAmount?.toString() ?? '-1')} - ${Converter
        .formatNumber(
        method?.maxAmount?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  Future<void> getDepositMethod() async {
    currency = depositRepo.apiClient.getCurrencyOrUsername();
    methodList.clear();
    methodList.add(paymentMethod!);
    ResponseModel responseModel = await depositRepo.getDepositMethods();
    if (responseModel.statusCode == 200) {
      DepositMethodResponseModel methodsModel =
      DepositMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (methodsModel.message != null &&
          methodsModel.message!.success != null) {
        List<Methods>? tempList = methodsModel.data?.methods;
        if (tempList != null && tempList.isNotEmpty) {
          methodList.addAll(tempList);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      return;
    }
    isLoading = false;
    update();
  }

  bool submitLoading = false;
  Future<void> submitDeposit() async {

    if(paymentMethod?.id.toString()=='-1'){
      CustomSnackBar.error(errorList: [MyStrings.selectPaymentMethod]);
      return;
    }

   // String amount = amountController.text.toString();
    // if (amount.isEmpty) {
    //   CustomSnackBar.error(errorList: [MyStrings.enterAmount]);
    //   return;
    // }

    submitLoading = true;
    update();

    ResponseModel responseModel = await depositRepo.insertDeposit(
        amount: amount,
        methodCode: methodCodee?? "",
        currency: paymentMethod?.currency ?? "");
        print(responseModel);
    if (responseModel.statusCode == 200) {
      submitLoading = false;
      update();
      Get.defaultDialog(
          backgroundColor: MyColor.colorWhite,
          title: 'Success',
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Please follow the instruction below Effettua un Bonifico alle seguenti coordinate',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),),
              Text('Iban: it31y0538703214000002295834',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),),
              Text('Il credito sarà confermato dopo la ricezione del bonifico.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),),

            ],),
          buttonColor: MyColor.primaryColor,
          textConfirm: 'OK',
           confirmTextColor: MyColor.colorWhite,
           onConfirm: (){
            Get.back();
           },
           titleStyle: const TextStyle(color: MyColor.primaryColor)
      );
      DepositInsertResponseModel insertResponseModel =
      DepositInsertResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      if (insertResponseModel.status.toString().toLowerCase() == "success") {
       // showWebView(insertResponseModel.data?.redirectUrl ?? "");



      } else {
        CustomSnackBar.error(errorList: insertResponseModel.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    submitLoading = false;
    update();

  }



  void changeInfoWidgetValue(double amount){
    if(paymentMethod?.id.toString() == '-1'){
      return;
    }
    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${Converter.formatNumber('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '$payable $currency';

    rate = double.tryParse(paymentMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency??''}';
    inLocal = Converter.formatNumber('${payable*rate}');
    update();
    return;
  }

  void clearData() {
    depositLimit = '';
    charge = '';
    methodList.clear();
    amountController.text = '';
    isLoading = false;
  }

  bool isShowRate() {
    if(rate>1 && currency.toLowerCase() != paymentMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  void showWebView(String redirectUrl) {
    Get.offAndToNamed(RouteHelper.depositWebViewScreen, arguments: redirectUrl);
  }


  ///  nido work.. it is for transfer search api and autofill name and account
  var isLoadingSearch = true.obs;
  String token='';
  String tokenType='';
  DepositModelSearch depositModelSearch  =DepositModelSearch();
  Future<void> searchDepositAccountApi(String parameter) async {
    isLoadingSearch.value = true;
    SharedPreferences sharedPreferences   = await SharedPreferences.getInstance();
    token   =  sharedPreferences!.getString(SharedPreferenceHelper.accessTokenKey)!;
    print(token);
    try {


      Uri fullUrl = Uri.parse('https://kosmomoney.com/api/gateways/$parameter');

      log('Full URL: $fullUrl'); // Log the complete URL
      var headers = {
        //'Authorization': 'Bearer 15|xtkFgvCjEYd3LYjwyVvlShe4WOnQuxqrvBK4CaGS'
        "Authorization": "Bearer $token"
      };
      final response = await http.get(
          fullUrl,
          headers:headers
      );
      print('code: ${response.statusCode}');
      if (response.statusCode == 200) {
        // Successful response, handle data

        print('code: ${response.statusCode}');
        depositModelSearch  = depositModelSearchFromJson(response.body.toString());
              amountController.text   = depositModelSearch.data!.finalAmount.toString();
             currency  = depositModelSearch.data!.currency.toString();
              amount   = depositModelSearch.data!.payable!;
              payableText=  depositModelSearch.data!.payable.toString();
            methodCodee  = depositModelSearch.data!.methodCode.toString();
          log('selected amount');
          log(amount.toString());
          log(response.body.toString());
         // Parse the JSON response directly

        isLoadingSearch.value = false;
        update();
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
    } finally {
      isLoadingSearch.value = false;
      update();
    }
  }

}