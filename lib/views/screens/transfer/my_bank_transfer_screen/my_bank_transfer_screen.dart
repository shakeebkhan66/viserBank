import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import 'package:viser_bank/data/repo/transfer_repo/transfer_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
import 'package:viser_bank/views/components/text-field/custom_amount_text_field.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/my_bank_list_item.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/my_bank_transfer_bottom_sheet.dart';

import 'widget/add_my_bank_beneficiary_bottom_sheet.dart';

class MyBankTransferScreen extends StatefulWidget {
  const MyBankTransferScreen({Key? key}) : super(key: key);

  @override
  State<MyBankTransferScreen> createState() => _MyBankTransferScreenState();
}

class _MyBankTransferScreenState extends State<MyBankTransferScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<MyBankTransferController>().hasNext()){
        Get.find<MyBankTransferController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BeneficiaryRepo(apiClient: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(MyBankTransferController(repo: Get.find(),beneficiaryRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });

    // open bottom sheet
    controller.accountNoController.clear();
    controller.accountNameController.clear();
    controller.amountController.clear();
    Future.delayed(const Duration(seconds: 1), (){
      MyBankTransferBottomSheet().transferBottomSheet(context, 0);
      controller.accountNoController.clear();
      controller.accountNameController.clear();
      controller.amountController.clear();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: GetBuilder<MyBankTransferController>(builder: (controller)=>Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(title: MyStrings.transferWithinViserBank,
            isShowActionBtn: true,
            press: (){
                print('object');
             // AddMyBankBeneficiariesBottomSheet.showBottomSheet(context);
              log('message');
                  controller.accountNoController.clear();
                  controller.accountNameController.clear();
                  controller.amountController.clear();
                MyBankTransferBottomSheet().transferBottomSheet(context, 0);
                controller.accountNoController.clear();
                controller.accountNameController.clear();
                controller.amountController.clear();
            },
            actionText: MyStrings.addNew,actionIcon: Icons.add,isActionIconAlignEnd: false),
        body: controller.isLoading?const CustomLoader(): controller.beneficiaryList.isEmpty?const NoDataFoundScreen():Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenPaddingH, vertical: Dimensions.screenPaddingV),
          child: ListView.builder(
              controller: scrollController,
              itemCount: controller.beneficiaryList.length+1,
              itemBuilder: (context,index){
                if(controller.beneficiaryList.length == index){
                  return controller.hasNext() ? SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CustomLoader(),
                    ),
                  ) : const SizedBox();
                }
                return MyBankTransferListItem(
                    accountName: controller.beneficiaryList[index].accountName??'',
                    accountNumber: controller.beneficiaryList[index].accountNumber??'',
                    accountType: controller.beneficiaryList[index].sentTo?.accountType ??'',
                    shortName: controller.beneficiaryList[index].shortName??'',
                    index: index
                );
              })
        ),
      )),
    );
  }
}
