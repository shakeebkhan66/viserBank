import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:viser_bank/views/components/text-field/custom_text_field.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/show_result_search_screen.dart';



class AddMyBankBeneficiariesBottomSheet{
  static void showBottomSheet(BuildContext context){
    Get.find<MyBankTransferController>().clearTextField();
    CustomBottomSheet(child: GetBuilder<MyBankTransferController>(builder: (controller)=>

        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTopRow(header: MyStrings.addBeneficiaryToVBank),
          const SizedBox(height: Dimensions.space12),
          Focus(
            onFocusChange: (focus){
              if(!focus){
                controller.changeMobileFocus(focus, false);


              }
            },
            child: CustomTextField(
                controller: controller.accountNameController,
                labelText: MyStrings.accountName,
                hintText: MyStrings.enterAccountName,
                needOutlineBorder: true,
                isRequired:true,
                onChanged: (value){
                  if(value.toString().length >4){
                    controller.searchTransferAccountApi(value);

                       Future.delayed(const Duration(seconds: 1),(){
                         if(controller.searchApiModel.data!.users!.isNotEmpty){
                           Get.to(const ShowSearchResultScreen());
                         }
                       });

                  }

                }
            ),
          ),
        const  SizedBox(height: Dimensions.space15,),
          Focus(
            onFocusChange: (focus){
              if(!focus){
                controller.changeMobileFocus(focus, true);

              }
            },
            child: CustomTextField(
                controller: controller.accountNoController,
                labelText: MyStrings.accountNumber,
                hintText: MyStrings.enterAccountNumber,
                isRequired:true,
                needOutlineBorder: true,
                onChanged: (value){}
            ),
          ),
          const SizedBox(height: Dimensions.space15,),
          CustomTextField(
              controller: controller.shortNameController,
              needOutlineBorder: true,
              labelText: MyStrings.shortName,
              hintText: MyStrings.enterShortName,
              isRequired:true,
              onChanged: (value){}
          ),
          const SizedBox(height: Dimensions.space30,),
          controller.isSubmitLoading?const RoundedLoadingBtn():RoundedButton(text: MyStrings.submit, press: (){
            controller.addBeneficiary();
          })
        ],
      )
    )).customBottomSheet(context);
  }
}