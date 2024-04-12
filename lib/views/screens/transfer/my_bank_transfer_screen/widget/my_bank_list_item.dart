import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/util.dart';
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/views/components/column/card_column.dart';
import 'package:viser_bank/views/components/divider/custom_divider.dart';

import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import 'my_bank_transfer_bottom_sheet.dart';

class MyBankTransferListItem extends StatelessWidget {

  final String accountName;
  final String accountNumber;
  final String shortName;
  final int index;

  const MyBankTransferListItem({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.shortName,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBankTransferController>(builder: (controller)=>InkWell(
      onTap: (){
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.cardMargin),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.cyan.shade50,
              Colors.cyan.shade50
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0.2, 0.0), // changes position of shadow
            ),
          ],
          border: Border.all(
            color: Colors.greenAccent.shade100,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 180,
                  height: 60,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardColumn(header: MyStrings.accountName, body: accountName),
                      CardColumn(header: MyStrings.accountNumber, body: accountNumber),
                      // CardColumn(alignmentEnd:true,header: MyStrings.shortName, body: shortName)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    controller.accountNameController.text = controller.beneficiaryList[index].accountName!;
                    controller.accountNoController.text = controller.beneficiaryList[index].accountNumber!;
                    MyBankTransferBottomSheet().transferBottomSheet(context, index);
                  },
                  child: Container(
                    height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                          color: MyColor.primaryColor),
                      child:Row(
                        children: [
                          SvgPicture.asset(
                            MyImages.sendIcon,
                            color: MyColor.textColor,
                            height: 11,width: 11,
                          ),
                          const SizedBox(width: Dimensions.space7),
                          Text(
                            MyStrings.transfer.tr,
                            style: interRegularDefault.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontSmall12),
                          )
                        ],
                      )
                  ),
                )
              ],
            )


            //
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     CardColumn(header: MyStrings.accountName, body: accountName),
            //     CardColumn(header: MyStrings.accountNumber, body: accountNumber),
            //     // CardColumn(alignmentEnd:true,header: MyStrings.shortName, body: shortName)
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const SizedBox(
            //       width: 190.0,
            //       child: CustomDivider(),
            //     ),
            //     InkWell(
            //       onTap: (){
            //         controller.accountNameController.text = controller.beneficiaryList[index].accountName!;
            //         controller.accountNoController.text = controller.beneficiaryList[index].accountNumber!;
            //         MyBankTransferBottomSheet().transferBottomSheet(context, index);
            //       },
            //       child: Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
            //               color: MyColor.primaryColor),
            //           child:Row(
            //             children: [
            //               SvgPicture.asset(
            //                 MyImages.sendIcon,
            //                 color: MyColor.textColor,
            //                 height: 11,width: 11,
            //               ),
            //               const SizedBox(width: Dimensions.space7),
            //               Text(
            //                 MyStrings.transfer.tr,
            //                 style: interRegularDefault.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontSmall12),
            //               )
            //             ],
            //           )
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //    children: [
            //         CardColumn(header: MyStrings.accountNumber, body: accountNumber),
            //         const SizedBox(width: 35),
            //      //    InkWell(
            //      //      onTap: (){
            //      //       controller.accountNameController.text = controller.beneficiaryList[index].accountName!;
            //      //       controller.accountNoController.text = controller.beneficiaryList[index].accountNumber!;
            //      //        MyBankTransferBottomSheet().transferBottomSheet(context, index);
            //      //     },
            //      //   child: Container(
            //      //     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
            //      //     decoration: BoxDecoration(
            //      //         borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
            //      //         color: MyColor.primaryColor),
            //      //     child:Row(
            //      //       children: [
            //      //         SvgPicture.asset(
            //      //           MyImages.sendIcon,
            //      //           color: MyColor.textColor,
            //      //           height: 11,width: 11,
            //      //         ),
            //      //         const SizedBox(width: Dimensions.space7),
            //      //         Text(
            //      //           MyStrings.transfer.tr,
            //      //           style: interRegularDefault.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontSmall12),
            //      //         )
            //      //       ],
            //      //     )
            //      //   ),
            //      // )
            //       ],
            //     ),
          ],
        ),
      ),
    ));
  }
}
