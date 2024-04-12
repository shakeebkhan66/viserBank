import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:viser_bank/data/controller/transfer/transfer_controller.dart';
import 'package:viser_bank/data/repo/transfer_repo/transfer_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:viser_bank/views/components/text-field/custom_text_field.dart';
import 'package:viser_bank/views/screens/transfer/my_bank_transfer_screen/widget/show_result_search_screen.dart';

import '../../../data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import '../../components/appbar/custom_appbar.dart';

class PaymentWithPercentage extends StatefulWidget {
  const PaymentWithPercentage({Key? key}) : super(key: key);

  @override
  State<PaymentWithPercentage> createState() => _PaymentWithPercentageState();
}

class _PaymentWithPercentageState extends State<PaymentWithPercentage> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BeneficiaryRepo(apiClient: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(MyBankTransferController(
        repo: Get.find(), beneficiaryRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.containerBgColor,
        // appBar: AppBar(
        //   title: Text(
        //     'Richiedi KMoney',
        //       // 'Payment With %',
        //       style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
        //   backgroundColor: MyColor.primaryColor,
        //   elevation: 0,
        //   automaticallyImplyLeading: true,
        // ),
        appBar: const CustomAppBar(title: "Richiedi KMoney"),
        body: GetBuilder<MyBankTransferController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       margin: const EdgeInsets.only(left: 150, top: 20),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         gradient: LinearGradient(
                  //             begin: Alignment.centerLeft,
                  //             end: Alignment.centerRight,
                  //             colors: [
                  //               Colors.cyan.shade200,
                  //               Colors.lightBlueAccent.shade200,
                  //             ]
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       margin: const EdgeInsets.only(left: 35, top: 20),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         gradient: LinearGradient(
                  //             begin: Alignment.centerLeft,
                  //             end: Alignment.centerRight,
                  //             colors: [
                  //               Colors.cyan.shade200,
                  //               Colors.lightBlueAccent.shade200,
                  //             ]
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   height: 15,
                  //   width: 15,
                  //   margin: const EdgeInsets.only(left: 185),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(100),
                  //     gradient: LinearGradient(
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //         colors: [
                  //           Colors.cyan.shade200,
                  //           Colors.lightBlueAccent.shade200,
                  //         ]
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 30,
                  //   width: 30,
                  //   margin: const EdgeInsets.only(left: 155),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(100),
                  //     gradient: LinearGradient(
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //         colors: [
                  //           Colors.cyan.shade200,
                  //           Colors.lightBlueAccent.shade200,
                  //         ]
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 20,
                  //   width: 20,
                  //   margin: const EdgeInsets.only(left: 125, top: 5.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(100),
                  //     gradient: LinearGradient(
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //         colors: [
                  //           Colors.cyan.shade200,
                  //           Colors.lightBlueAccent.shade200,
                  //         ]
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: Dimensions.space20),
                  Focus(
                    onFocusChange: (focus) {
                      if (!focus) {
                        controller.changeMobileFocus(focus, false);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextField(
                          controller: controller.accountNameController,
                          labelText: MyStrings.accountName,
                          hintText: MyStrings.enterAccountName,
                          needOutlineBorder: true,
                          isRequired: true,
                          onChanged: (value) {
                            if (value.toString().length > 4) {
                              controller.searchTransferAccountApi(value);

                              Future.delayed(const Duration(seconds: 1),
                                      () {
                                    if (controller.searchApiModel.data!.users!
                                        .isNotEmpty) {
                                      Get.to(const ShowSearchResultScreen());
                                    }
                                  });
                            }
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  Focus(
                    onFocusChange: (focus) {
                      if (!focus) {
                        controller.changeMobileFocus(focus, true);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextField(
                          controller: controller.accountNoController,
                          labelText: MyStrings.accountNumber,
                          hintText: MyStrings.enterAccountNumber,
                          isRequired: true,
                          needOutlineBorder: true,
                          onChanged: (value) {}),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                        controller: controller.productNameController,
                        needOutlineBorder: true,
                        labelText: 'Product Name',
                        hintText: 'Product Name',
                        isRequired: true,
                        onChanged: (value) {}),
                  ),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                        controller: controller.productPriceController,
                        needOutlineBorder: true,
                        labelText: 'Product Price',
                        hintText: '0',
                        isRequired: true,
                        onChanged: (value) {}),
                  ),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                        controller: controller.percentageController,
                        needOutlineBorder: true,
                        labelText: 'KMoney in %',
                        hintText: '0%',
                        isRequired: true,
                        readOnly: true,
                        onTap: () {
                          print('object');
                          // Show the dropdown in a popup
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(0, 100, 0, 0),
                            items: [0, 25, 50, 75, 100]
                                .map<PopupMenuEntry<int>>((int value) {
                              return PopupMenuItem<int>(
                                value: value,
                                child: Text('$value%'),
                              );
                            }).toList(),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                controller.percentageController.text = value.toString();
                              });
                              // Handle the selected value here
                              print('Selected value: $value%');
                              // You can update the state or controller with the selected value
                            }
                          });
                        },
                        onChanged: (value) {}),
                  ),
                  const SizedBox(
                    height: Dimensions.space30,
                  ),
                  controller.isSubmitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                    text: MyStrings.submit,
                    press: () {
                      controller.addBeneficiaryPercentage();
                    },),
                ],
              ),
            )));
  }
}
