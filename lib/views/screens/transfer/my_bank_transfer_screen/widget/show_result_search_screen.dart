



import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/views/components/custom_loader.dart';

import '../../../../../core/utils/style.dart';

class ShowSearchResultScreen extends StatefulWidget {
  const ShowSearchResultScreen({Key? key}) : super(key: key);

  @override
  State<ShowSearchResultScreen> createState() => _ShowSearchResultScreenState();
}

class _ShowSearchResultScreenState extends State<ShowSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: MyColor.colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: MyColor.primaryColor,
      ),
      body: GetBuilder<MyBankTransferController>(builder: (controller)=>ListView.builder(
        shrinkWrap: true,
       itemCount: controller.searchApiModel.data!.users!.length,
    itemBuilder: (_,index){

        return Obx(()=> controller.isLoadingSearch.value?const CustomLoader(): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: (){
                  controller.accountNameController.text  = controller.searchApiModel.data!.users![index].username.toString();
                  controller.accountNoController.text  = controller.searchApiModel.data!.users![index].accountNumber.toString();
                    Get.back();
                  controller.searchApiModel.data!.users!.clear();
                },
              title: Text(controller.searchApiModel.data!.users![index].username.toString(),
               style: interRegularDefault.copyWith(color: MyColor.colorBlack,fontWeight: FontWeight.w600),
              ),
            subtitle: Text(controller.searchApiModel.data!.users![index].accountNumber.toString(),
           style: interRegularDefault.copyWith(color: MyColor.colorBlack),
    ),
              ),
              const Divider(
                color: MyColor.primaryColor,
              ),
            ],
          ),
        );
    },),
    ));
  }
}
