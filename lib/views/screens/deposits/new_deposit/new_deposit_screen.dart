
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/deposit/add_new_deposit_controller.dart';
import 'package:viser_bank/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:viser_bank/data/repo/deposit/deposit_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/text-field/custom_amount_text_field.dart';
import 'package:viser_bank/views/components/text-field/custom_drop_down_button_with_text_field2.dart';
import 'package:viser_bank/views/screens/deposits/new_deposit/info_widget.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/helper/string_format_helper.dart';
import '../../../../data/controller/deposit/deposit_history_controller.dart';
import '../../../components/no_data/no_data_found_screen.dart';
import '../widget/custom_deposits_card.dart';
import '../widget/deposit_bottom_sheet.dart';
import '../widget/deposit_history_top.dart';

class NewDepositScreen extends StatefulWidget {
  const NewDepositScreen({Key? key}) : super(key: key);

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {

  final ScrollController scrollController = ScrollController();
  late DepositController depositController;
  // final depositController = Get.put(DepositController(depositRepo: Get.find()));


  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<DepositController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    depositController = Get.put(DepositController(depositRepo: Get.find()));
    final controller = Get.put(AddNewDepositController(
      depositRepo: Get.find(),
    ));
    controller.searchDepositAccountApi('0');
    controller.getDepositMethod();
    super.initState();
    controller.amountController.clear();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      depositController.beforeInitLoadData();
      scrollController.addListener(_scrollListener);
    });
  }


  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor2(),
        appBar: const CustomAppBar(title: MyStrings.newDepositScreen),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColor.getScreenBgColor2(),
                    borderRadius:
                        BorderRadius.circular(Dimensions.defaultBorderRadius),
                  ),
                  child: Column(
                    children: [
                      Form(
                        child: Obx(
                          () => controller.isLoadingSearch.value
                              ? const CustomLoader()
                              :
                          Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDropDownTextField2(
                                      labelText: '',
                                      selectedValue: controller.paymentMethod,
                                      onChanged: (newValue) {
                                        controller.setPaymentMethod(newValue);
                                      },
                                      items:
                                          controller.methodList.map((Methods bank) {
                                        return DropdownMenuItem<Methods>(
                                          onTap: () {
                                            print("bank ${bank.name.toString()}");
                                            if(bank.name.toString() == 'top-up 10 to 110'){
                                                    setState(() {
                                                      controller.selectedNumber = '10 to 110';
                                                      controller.amountController.clear();
                                                      controller.payableText = '';
                                                      controller.selectedNumber1 = 'select one';
                                                    });
                                              print(controller.selectedNumber
                                                  .toString());
                                            }else if(bank.name.toString() == 'KyCard120'){
                                              controller.selectedNumber = '';
                                              controller.searchDepositAccountApi(
                                                 '120');
                                            }else if(bank.name.toString() == 'KyCard1200'){
                                              controller.selectedNumber = '';
                                              controller.searchDepositAccountApi(
                                                  '1200');
                                            }else if(bank.name.toString() == 'KyCard2400'){
                                              controller.selectedNumber = '';
                                              controller.searchDepositAccountApi(
                                                  '2400');
                                            }else if(bank.name.toString() == 'KyCard3600'){
                                              controller.selectedNumber = '';
                                              controller.searchDepositAccountApi(
                                                  '3600');
                                            }

                                          },
                                          value: bank,
                                          child: Center(
                                            child: Text(
                                                (bank.name  ?? '').tr + " " +"KyCard",
                                                style: const TextStyle(color: MyColor.titleColor, fontWeight: FontWeight.w600)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: Dimensions.space15),
                                    if (controller.selectedNumber
                                            .toString() ==
                                        '10 to 110')
                                      CustomDropDownTextField2(
                                        labelText: MyStrings.selectOone.tr,
                                        selectedValue: controller.selectedNumber1 , // Add null check
                                        onChanged: (value) {
                                          setState(() {
                                            controller.selectedNumber1 = value!;
                                          });
                                        },
                                        items: [
                                          'select one','10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110'
                                        ].map((number) => DropdownMenuItem<String>(
                                          onTap: () {
                                            controller.selectedNumber1 = number;
                                            controller.searchDepositAccountApi(
                                                number.toString());
                                          },
                                          value: number,
                                          child: Text(
                                            number== "select one"? MyStrings.selectOone.tr : number,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                    const SizedBox(height: Dimensions.space15),
                                    CustomAmountTextField(
                                      readOnly: true,
                                      labelText: MyStrings.amount.tr,
                                      hintText: MyStrings.enterAmount.tr,
                                      inputAction: TextInputAction.done,
                                      currency: controller.currency,
                                      controller: controller.amountController,
                                      onChanged: (value) {
                                        if (value.toString().isEmpty) {
                                          controller.changeInfoWidgetValue(0);
                                        } else {
                                          double amount =
                                              double.tryParse(value.toString()) ??
                                                  0;
                                          controller.changeInfoWidgetValue(amount);
                                        }
                                        return;
                                      },
                                    ),
                                    controller.paymentMethod?.name !=
                                            MyStrings.selectOne
                                        ? const InfoWidget()
                                        : const SizedBox(),
                                    const SizedBox(height: 35),
                                    controller.submitLoading
                                        ? const RoundedLoadingBtn()
                                        : RoundedButton(
                                            text: MyStrings.submit,
                                            textColor: MyColor.colorWhite,
                                            width: double.infinity,
                                            press: () {
                                              controller.submitDeposit();
                                            },
                                          )
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 400,
                       // color: Colors.red,
                       child:controller.isLoading ? const CustomLoader() : Column(
                         children: [
                           Visibility(
                             visible: depositController.isSearch,
                             child: const Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 DepositHistoryTop(),
                                 SizedBox(height: Dimensions.space15),
                               ],
                             ),
                           ),
                           Expanded(
                             child: depositController.depositList.isEmpty && depositController.searchLoading == false ? NoDataFoundScreen(title:MyStrings.noDepositFound.tr, height:depositController.isSearch?0.75:0.8) :
                             depositController.searchLoading ? const Center(
                               child: CustomLoader(),
                             ) : SizedBox(
                               height: MediaQuery.of(context).size.height,
                               child: ListView.separated(
                                 shrinkWrap: true,
                                 controller: scrollController,
                                 scrollDirection: Axis.vertical,
                                 physics: const BouncingScrollPhysics(),
                                 padding: EdgeInsets.zero,
                                 itemCount: depositController.depositList.length+1,
                                 separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                                 itemBuilder: (context, index) {
                                   if(depositController.depositList.length == index){
                                     return depositController.hasNext() ? SizedBox(
                                       height: 40,
                                       width: MediaQuery.of(context).size.width,
                                       child: const Center(
                                         child: CustomLoader(),
                                       ),
                                     ) : const SizedBox();
                                   }
                                   return CustomDepositsCard(
                                     onPressed: (){

                                       DepositBottomSheet.depositBottomSheet(context,index);
                                     },
                                     trxValue: depositController.depositList[index].trx ?? "",
                                     date: DateConverter.isoToLocalDateAndTime(depositController.depositList[index].createdAt ?? ""),
                                     status: depositController.getStatus(index),
                                     statusBgColor:depositController.getStatusColor(index),
                                     amount: "${Converter.formatNumber(depositController.depositList[index].amount ?? " ")} ${controller.currency}",
                                   );
                                 },
                               ),
                             ),
                           ),
                         ],
                       ),
                      ),
                    ],
                  ),
                ),
              ),
      )),
    );
  }
}
