import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/model/dashboard/dashboard_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/repo/home/home_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;

import '../../../model/module_model.dart';

class HomeController extends GetxController {

  HomeRepo repo;
  HomeController({required this.repo});

  bool isLoading = true;
  String username = "";
  String email = "";
  String balance = "";
  String wallet = "";
  String accountNumber = "";
  String accountName = "";
  String currency = "";
  String currencySymbol = "";
  String userType = "";
  String imagePath = "";
  double? bothBalance;
  List<LatestDebitsData> debitsLists = [];
  List<Module>moduleList = [];

  Future<void> loadData() async{

    moduleList = repo.apiClient.getModuleList();
    print("module $moduleList");
    print("module ${moduleList.length}");

    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    ResponseModel responseModel = await repo.getData();

    debitsLists.clear();

    if(responseModel.statusCode == 200){
      DashboardResponseModel model = DashboardResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == 'success'){
        username = model.data?.user?.username ?? "";
        email = model.data?.user?.email ?? "";
         userType = model.data?.user!.userType ?? "";
         print('myUser: ${userType}');
        accountNumber = model.data?.user?.accountNumber ?? "";
        imagePath = model.data?.user?.image??'';

        balance = Converter.formatNumber(model.data?.user?.balance ?? "");
        wallet = Converter.formatNumber(model.data?.user?.wallet ?? "");
        // Parse strings to double
        double parsedBalance = double.tryParse(balance) ?? 0.0;
        double parsedWallet = double.tryParse(wallet) ?? 0.0;



        if (userType == 'agent') {
          // Calculate total balance for customer
          bothBalance = parsedBalance + parsedWallet;
          print('if Working');
          print(bothBalance);
        } else {
          // For other user types
          print('else Working');
          bothBalance = parsedWallet;
          print(bothBalance);
        }

        List<LatestCreditsData>? tempCreditList = model.data?.latestCredits?.data;
        if(tempCreditList != null && tempCreditList.isNotEmpty){
          for (var element in tempCreditList) {
            debitsLists.add(LatestDebitsData(
                amount: element.amount,
                charge: element.charge,
                postBalance: element.postBalance,
                trxType: element.trxType,
               trx: element.trx,
              details: element.details,
              remark: element.details,
              createdAt: element.createdAt,
              updatedAt: element.updatedAt
            ));
          }
        }

        List<LatestDebitsData>? tempDebitList = model.data?.latestDebits?.data;
        if(tempDebitList != null && tempDebitList.isNotEmpty){
          debitsLists.addAll(tempDebitList);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ??[ MyStrings.somethingWentWrong],);
      }
    }
    else{
      if (responseModel.statusCode == 503) {
        changeNoInternetStatus(true);
      }
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    isLoading = false;
    update();
    await repo.refreshGeneralSetting();
    moduleList = repo.apiClient.getModuleList();
    update();
  }


 /* bool isCreditSelected = true;
  void changeButtonState(bool status){
    isCreditSelected = status;
    update();
  }*/


  bool noInternet = false;
  void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
  }



}


