import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/model/authorization/authorization_response_model.dart' as auth_model;
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/model/transfer/beneficiary/check_account_response_model.dart';
import 'package:viser_bank/data/model/transfer/beneficiary/my_bank_beneficiary_response_model.dart';
import 'package:viser_bank/data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import 'package:viser_bank/data/repo/transfer_repo/transfer_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/search_api_model.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/show_result_search_screen.dart';
class MyBankTransferController extends GetxController{

  TransferRepo repo;
  BeneficiaryRepo beneficiaryRepo;
  MyBankTransferController({required this.repo,required this.beneficiaryRepo});

  bool isLoading = true;
  List<Data> beneficiaryList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String limitPerTrx = '0';
  String dailyMaxLimit = '0';
  String monthlyLimit = '0';
  String chargePerTrx = '0';

  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }

  Future<void> loadPaginationData() async{
    await loadHistoryList();
    update();
  }

  void initialSelectedValue() async{
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    authorizationList = repo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    page = 0;
    beneficiaryList.clear();
    isLoading = true;
    update();
    await loadHistoryList();
    isLoading = false;
    update();
  }

  Future<void> loadHistoryList() async{

    page = page + 1;
    if(page == 1){
      beneficiaryList.clear();
    }

    ResponseModel responseModel = await beneficiaryRepo.getMyBankBeneficiary(page);
    if(responseModel.statusCode == 200){
      MyBankBeneficiaryResponseModel model = MyBankBeneficiaryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.beneficiaries?.nextPageUrl ?? "";
      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempBeneficiaryList = model.data?.beneficiaries?.data;
        loadLimit(model);
        if(tempBeneficiaryList != null && tempBeneficiaryList.isNotEmpty){
          beneficiaryList.addAll(tempBeneficiaryList);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }
  
  void loadLimit(MyBankBeneficiaryResponseModel model){
    chargePerTrx = model.data?.transferCharge??'';
    limitPerTrx =  model.data?.general?.minimumTransferLimit??'0';
    dailyMaxLimit =  model.data?.general?.dailyTransferLimit ?? '0';
    monthlyLimit =  model.data?.general?.monthlyTransferLimit ?? '0';
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }




  TextEditingController amountController = TextEditingController();
 late auth_model.AuthorizationResponseModel model;
  bool submitLoading = false;
  void transferMoney({ name,account,auth,amount}) async{
    String amount = amountController.text;
    if(amount.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
      return;
    }

    if(authorizationList.length>1 && selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne.toLowerCase()){
      CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
      return;
    }

    submitLoading = true;
    update();
    ResponseModel response = await repo.myBankTransferRequest(amount:amount,authMode: selectedAuthorizationMode,name: name,account: account,);
    if(response.statusCode==200){
      model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        String otp = model.data?.otpId??'';
        if(otp.isNotEmpty && authorizationList.length>1){
          Get.offAndToNamed(RouteHelper.otpScreen,arguments:[RouteHelper.transferHistoryScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
        } else{
          Get.offAndToNamed(RouteHelper.transferHistoryScreen);
          CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        }
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    amountController.text = '';
    submitLoading = false;
    update();
  }





  void clearTextField(){
    accountNoController.text = '';
    accountNameController.text = '';
    shortNameController.text = '';
    productNameController.text = '';
    productPriceController.text = '';
    percentageController.text = '';
  }

  TextEditingController accountNoController   = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController shortNameController   = TextEditingController();
  TextEditingController productNameController   = TextEditingController();
  TextEditingController productPriceController   = TextEditingController();
  TextEditingController percentageController   = TextEditingController();
   var selectedPercentage  = 0;
  bool isSubmitLoading = false;
  void addBeneficiary() async{

    String accountNumber = accountNoController.text;
    String accountName = accountNameController.text;
    String shortName = shortNameController.text;

    if(accountNumber.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNumberRequired]);
      return ;
    }

    if(accountName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNameRequired]);
      return ;
    }

    if(shortName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.shortNameRequired]);
      return ;
    }

    isSubmitLoading = true;
    update();
    ResponseModel response = await beneficiaryRepo.addBeneficiary(accountNumber,accountName,shortName);
    if(response.statusCode==200){
      auth_model.AuthorizationResponseModel model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        Get.back();
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        initialSelectedValue();
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isSubmitLoading = false;
    update();
  }
  void addBeneficiaryPercentage() async{

    String accountNumber = accountNoController.text;
    String accountName = accountNameController.text;
    String pName = productNameController.text;
    String percentage = percentageController.text;
    String pPrice= productPriceController.text;

    if(accountNumber.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNumberRequired]);
      return ;
    }

    if(accountName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNameRequired]);
      return ;
    }

    if(pName.isEmpty){
      CustomSnackBar.error(errorList: ['Product name is required']);
      return ;
    }
    if(pPrice.isEmpty){
      CustomSnackBar.error(errorList: ['Price is required']);
      return ;
    }
    if(percentage.isEmpty){
      CustomSnackBar.error(errorList: ['Percentage is required']);
      return ;
    }

    isSubmitLoading = true;
    update();
    ResponseModel response = await beneficiaryRepo.addBeneficiaryPercentage(accountName: accountNumber,accountNumber: accountNumber,pName: pName,
    pPrice: pPrice,percentage: percentage
    );
    if(response.statusCode==200){
      // auth_model.AuthorizationResponseModel model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      // if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      //   Get.back();
      //   CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
      //   initialSelectedValue();
      // } else{
      //   CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      // }
      clearTextField();
      Get.defaultDialog(
          backgroundColor: MyColor.colorWhite,
          title: 'Success',
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Payment request created successfully.',
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
      print('success');
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isSubmitLoading = false;
    update();
  }
  bool hasAccountNumberFocus = false;
  void changeMobileFocus(bool hasFocus,bool isAccountNo) async{
    hasAccountNumberFocus = hasFocus;
    if(hasAccountNumberFocus==false){
      String value = isAccountNo?'account_number=${accountNoController.text.toString()}':'account_name=${accountNameController.text.toString()}';
      ResponseModel responseModel = await beneficiaryRepo.checkMyBankBeneficiary(value);
      if(responseModel.statusCode == 200){
        CheckAccountResponseModel model = CheckAccountResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if(model.data?.user!=null){
          String accountNumber = model.data?.user?.accountNumber??'';
          String accountName = model.data?.user?.accountName??'';
          accountNameController.text = accountName;
          accountNoController.text = accountNumber;
          try{
            FocusScope.of(Get.context!).unfocus();
          }catch(e){
            if (kDebugMode) {
            print(e.toString());
          }}

        }
      }
    }
    update();
  }

  bool isLimitShow = false;
  void changeLimitShowStatus(){
    isLimitShow = !isLimitShow;
    update();
  }
///  nido work.. it is for transfer search api and autofill name and account
  RxBool isLoadingSearch = true.obs;
  String token='';
  String tokenType='';
  SearchApiModel searchApiModel  =SearchApiModel();

  Future<void> searchTransferAccountApi(String parameter) async {
    SharedPreferences sharedPreferences   = await SharedPreferences.getInstance();
    token   =  sharedPreferences!.getString(SharedPreferenceHelper.accessTokenKey)!;
    print(token);
    try {

      isLoadingSearch.value = true;

      Uri fullUrl = Uri.parse('https://kosmomoney.com/api/search/user/$parameter');

      log('Full URL: $fullUrl'); // Log the complete URL
      var headers = {
        //'Authorization': 'Bearer 15|xtkFgvCjEYd3LYjwyVvlShe4WOnQuxqrvBK4CaGS'
        "Authorization": "Bearer $token"
      };
      final response = await http.get(
        fullUrl,
        headers:headers
      );

      if (response.statusCode == 200) {
        // Successful response, handle data
        print('code: ${response.statusCode}');
        log('Data: ${response.body}');
        searchApiModel  = searchApiModelFromJson(response.body.toString());
        Future.delayed(const Duration(milliseconds: 50),(){
          if(searchApiModel.data!.users!.isNotEmpty){
            Get.to(const ShowSearchResultScreen());
          }
        });
        isLoadingSearch.value = false;
      } else {
        // Handle errors, you can throw an exception or set an error message
        print('Data: ${response.body}');
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
    } finally {
      isLoadingSearch.value = false;
    }
  }
  var sendMoneyLoading  = false.obs;
  Future<void> sendMoney({name,account,amount,auth}) async {
    SharedPreferences sharedPreferences   = await SharedPreferences.getInstance();
    token   =  sharedPreferences!.getString(SharedPreferenceHelper.accessTokenKey)!;
    print(token);
    try {

      submitLoading = true;
      update();

      Uri fullUrl = Uri.parse('https://kosmomoney.com/api/own/transfer/sendKmoney');

      log('Full URL: $fullUrl'); // Log the complete URL
      // Log the complete URL
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
      };
      log('headers: $headers');
      var requestData = {
        'username':name,
        'amount': amount,
        'account_number': account,
        'auth_mode': auth,
      };
      log('working');
      final response = await http.post(
          fullUrl,
          headers:headers,
        body: json.encode(requestData),
      );
     log(json.encode(requestData));

      if (response.statusCode == 200) {
        log('Data: ${response.body}');

        if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
          String otp = model.data?.otpId ?? '';
          if (otp.isNotEmpty && authorizationList.length > 1) {
            Get.offAndToNamed(RouteHelper.otpScreen, arguments: [
              RouteHelper.transferHistoryScreen,
              model.data?.otpId,
              selectedAuthorizationMode?.toLowerCase().toString()
            ]);
          } else {
            Get.offAndToNamed(RouteHelper.transferHistoryScreen);
            CustomSnackBar.success(successList: model.message?.success ??
                [MyStrings.requestSuccess]);
          }
        }
        submitLoading = false;
        update();
      } else {
        // Handle errors, you can throw an exception or set an error message
        print('Data: ${response.body}');
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
    } finally {
      print('Exception: ');
      submitLoading = false;
      update();
    }
  }


}