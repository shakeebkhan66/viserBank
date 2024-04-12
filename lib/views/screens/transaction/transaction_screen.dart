import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/date_converter.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/core/utils/util.dart';
import 'package:viser_bank/data/controller/transaction/transaction_controller.dart';
import 'package:viser_bank/data/repo/account/transaction_log_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
import 'package:viser_bank/views/components/text/label_text.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/transaction/widget/bottom_sheet.dart';
import 'package:viser_bank/views/screens/transaction/widget/custom_transaction_card.dart';
import 'package:viser_bank/views/screens/transaction/widget/filter_row_widget.dart';

import '../../components/appbar/custom_appbar.dart';
import '../../components/text/label_text1.dart';
import '../home/widget/latest_transaction.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<TransactionController>().loadTransaction();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<TransactionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller =
        Get.put(TransactionController(transactionRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current locale
    Locale currentLocale = Localizations.localeOf(context);
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: SafeArea(
        child: GetBuilder<TransactionController>(
          builder: (controller) => Scaffold(
            backgroundColor: MyColor.containerBgColor,
            // appBar: AppBar(
            //   backgroundColor: MyColor.primaryColor.withOpacity(0.8),
            //   elevation: 0,
            //   centerTitle: true,
            //   leading: const SizedBox(),
            //   title: Text(
            //     MyStrings.transaction.tr,
            //     style: const TextStyle(
            //         color: MyColor.colorWhite,
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600),
            //   ),
            //   // actions: [
            //   //   Padding(
            //   //     padding: const EdgeInsetsDirectional.only(end: Dimensions.space15),
            //   //     child: GestureDetector(
            //   //       onTap: (){
            //   //         controller.changeSearchIcon();
            //   //       },
            //   //       child: Container(
            //   //         height: 30, width: 30,
            //   //         alignment: Alignment.center,
            //   //         decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
            //   //         child: controller.isSearch ? const Icon(
            //   //             Icons.clear,
            //   //             color: MyColor.primaryColor,
            //   //             size: 15
            //   //         ) : Image.asset(
            //   //           MyImages.filter,
            //   //           color: MyColor.primaryColor,
            //   //           height: 15, width: 15
            //   //         ),
            //   //       ),
            //   //     ),
            //   //   )
            //   // ],
            // ),
            appBar: CustomAppBar(title: MyStrings.transaction.tr),
            body: controller.isLoading
                ? const CustomLoader()
                : Padding(
                    padding: Dimensions.screenPaddingHV,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: controller.isSearch,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 13),
                            margin: const EdgeInsets.only(
                                bottom: Dimensions.cardMargin),
                            decoration: BoxDecoration(
                                color: MyColor.getCardBg(),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                                boxShadow: MyUtil.getBottomSheetShadow()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(text: MyStrings.type),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          SizedBox(
                                            height: 40,
                                            child: FilterRowWidget(
                                                fromTrx: true,
                                                bgColor: Colors.transparent,
                                                text: controller
                                                        .selectedTrxType.isEmpty
                                                    ? MyStrings.trxType
                                                    : controller
                                                        .selectedTrxType,
                                                press: () {
                                                  showTrxBottomSheet(
                                                      controller
                                                          .transactionTypeList,
                                                      1,
                                                      MyStrings.selectTrxType,
                                                      context: context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(
                                              text: MyStrings.remark),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          SizedBox(
                                            height: 40,
                                            child: FilterRowWidget(
                                                fromTrx: true,
                                                bgColor: Colors.transparent,
                                                text: Converter
                                                    .replaceUnderscoreWithSpace(
                                                        controller
                                                                .selectedRemark
                                                                .isEmpty
                                                            ? MyStrings.any
                                                            : controller
                                                                .selectedRemark),
                                                press: () {
                                                  log("Plus:${controller.plusRemarksList.length}");
                                                  log("Minus: ${controller.minusRemarksList.length}");
                                                  showTrxBottomSheet(
                                                      controller.selectedTrxType ==
                                                              "All"
                                                          ? controller
                                                              .remarksList
                                                              .map((e) => e
                                                                  .remark
                                                                  .toString())
                                                              .toList()
                                                          : controller.selectedTrxType ==
                                                                  "Plus"
                                                              ? controller
                                                                  .plusRemarksList
                                                                  .map((e) => e
                                                                      .remark
                                                                      .toString())
                                                                  .toList()
                                                              : controller
                                                                  .minusRemarksList
                                                                  .map((e) => e
                                                                      .remark
                                                                      .toString())
                                                                  .toList(),
                                                      2,
                                                      MyStrings
                                                          .selectRemarks.tr,
                                                      context: context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(
                                              text: MyStrings.trxNo),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          SizedBox(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextFormField(
                                              cursorColor: MyColor.primaryColor,
                                              style: interRegularSmall.copyWith(
                                                  color: MyColor.colorBlack),
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  controller.trxController,
                                              decoration: InputDecoration(
                                                  hintText: '',
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 15),
                                                  hintStyle: interRegularSmall.copyWith(
                                                      color: MyColor
                                                          .hintTextColor),
                                                  filled: true,
                                                  fillColor:
                                                      MyColor.transparentColor,
                                                  border: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              MyColor.colorGrey,
                                                          width: 0.5)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: const BorderSide(
                                                          color:
                                                              MyColor.colorGrey,
                                                          width: 0.5)),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: MyColor.titleColor, width: 0.5))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space10),
                                    InkWell(
                                      onTap: () {
                                        controller.filterData();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: MyColor.titleColor,
                                        ),
                                        child: const Icon(Icons.search_outlined,
                                            color: MyColor.colorWhite,
                                            size: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcATop, // You can adjust blendMode as needed
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [MyColor.primaryColor, MyColor.titleColor], // Gradient colors
                            ).createShader(bounds);
                          },
                          child: Text(
                            MyStrings.transaction.tr,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: Colors.cyan.withOpacity(0.3),
                                  blurRadius: 2,
                                  offset: const Offset(0.2, 0.2),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.date.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Nominativo",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                MyStrings.amount.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                            child: controller.transactionList.isEmpty &&
                                    controller.filterLoading == false
                                ? const Center(
                                    child: NoDataFoundScreen(),
                                  )
                                : controller.filterLoading
                                    ? const CustomLoader()
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView.separated(
                                          controller: scrollController,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller
                                                  .transactionList.length +
                                              1,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                  height: Dimensions.space10),
                                          itemBuilder: (context, index) {
                                            if (controller
                                                    .transactionList.length ==
                                                index) {
                                              return controller.hasNext()
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child:
                                                          const CustomLoader())
                                                  : const SizedBox();
                                            }
                                            return GestureDetector(
                                              onTap: () {
                                                controller
                                                    .changeExpandIndex(index);
                                              },
                                              child: CustomTransactionCard(
                                                index: index,
                                                expandIndex:
                                                    controller.expandIndex,
                                                trxType: controller
                                                        .transactionList[index]
                                                        .trxType ??
                                                    '',
                                                detailsText: controller
                                                        .transactionList[index]
                                                        .details ??
                                                    "",
                                                trxData: controller
                                                        .transactionList[index]
                                                        .trx ??
                                                    "",
                                                dateData: DateConverter
                                                    .isoToLocalDateAndTime(
                                                        controller
                                                                .transactionList[
                                                                    index]
                                                                .createdAt ??
                                                            ""),
                                                amountData:
                                                    "${controller.transactionList[index].trxType} ${Converter.formatNumber(controller.transactionList[index].amount.toString())} ${controller.transactionList[index].currency ?? ''}",
                                                postBalanceData:
                                                    "${Converter.formatNumber(controller.transactionList[index].postBalance.toString())} ${controller.transactionList[index].currency ?? ''}",
                                                transactionInfo: controller
                                                    .transactionList[index]
                                                    .transactionInfo!,
                                              ),
                                            );
                                          },
                                        ),
                                      ))
                      ],
                    ),
                  ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
          ),
        ),
      ),
    );
  }
}
