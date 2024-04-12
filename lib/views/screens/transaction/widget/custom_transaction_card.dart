import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/util.dart';
import 'package:viser_bank/data/controller/transaction/transaction_controller.dart';
import 'package:viser_bank/data/model/transaction/transaction_response_model.dart';
import 'package:viser_bank/views/components/animated_widget/expanded_widget.dart';
import 'package:viser_bank/views/components/column/card_column.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';

import '../../../../core/utils/style.dart';

// class CustomTransactionCard extends StatelessWidget {
//   final String trxData;
//   final String dateData;
//   final String amountData;
//   final String detailsText;
//   final String postBalanceData;
//   final int index;
//   final int expandIndex;
//   final String trxType;
//   final TransactionInfo transactionInfo;
//
//   const CustomTransactionCard({
//     Key? key,
//     required this.index,
//     required this.trxData,
//     required this.dateData,
//     required this.amountData,
//     required this.postBalanceData,
//     required this.expandIndex,
//     required this.detailsText,
//     required this.trxType,
//     required this.transactionInfo,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TransactionController>(
//       builder: (controller) => Container(
//         width: MediaQuery.of(context).size.width,
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
//         decoration: BoxDecoration(
//             color: MyColor.colorWhite,
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: MyUtil.getCardShadow()),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: CardColumn(header: MyStrings.trx, body: trxData)),
//                 Expanded(
//                   child: CardColumn(
//                     alignmentEnd: true,
//                     header: MyStrings.date,
//                     body: dateData,
//                     isDate: true,
//                   ),
//                 )
//               ],
//             ),
//             const WidgetDivider(
//               space: Dimensions.space15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: CardColumn(
//                       header: MyStrings.amount,
//                       body: '$amountData ${controller.currency}',
//                       textColor: controller.changeTextColor(trxType),
//                     )),
//                 Expanded(
//                     child: CardColumn(
//                         alignmentEnd: true,
//                         header: MyStrings.postBalance,
//                         body: '$postBalanceData ${controller.currency}')),
//               ],
//             ),
//             ExpandedSection(
//               expand: expandIndex == index,
//               child: Column(
//                 children: [
//                   const WidgetDivider(space: Dimensions.space15),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CardColumn(
//                                 header: MyStrings.details.tr, body: detailsText.tr)
//                           ],
//                         ),
//                       ),
//                       if (transactionInfo.type == null)
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "DA-A",
//                                 style: interRegularSmall.copyWith(
//                                     color: MyColor.getGreyText(),
//                                     fontWeight: FontWeight.w600),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                   "${transactionInfo.firstname!} ${transactionInfo.lastname!}",
//                                   style: interRegularDefault.copyWith(
//                                       fontStyle: FontStyle.italic,
//                                       color: MyColor.smallTextColor1,
//                                       fontSize: Dimensions.fontSmall)),
//                               Text("${transactionInfo.accountNumber}",
//                                   style: interRegularDefault.copyWith(
//                                       fontStyle: FontStyle.italic,
//                                       color: MyColor.smallTextColor1,
//                                       fontSize: Dimensions.fontSmall)),
//                             ],
//                           ),
//                         ),
//                       if (transactionInfo.type != null)
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "DA-A",
//                                 style: interRegularSmall.copyWith(
//                                     color: MyColor.getGreyText(),
//                                     fontWeight: FontWeight.w600),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text("${transactionInfo.type}".tr,
//                                   style: interRegularDefault.copyWith(
//                                       fontStyle: FontStyle.italic,
//                                       color: MyColor.smallTextColor1,
//                                       fontSize: Dimensions.fontSmall)),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class CustomTransactionCard extends StatefulWidget {
  final String trxData;
  final String dateData;
  final String amountData;
  final String postBalanceData;
  final String detailsText;
  final int index;
  final int expandIndex;
  final String trxType;
  final TransactionInfo transactionInfo;

  const CustomTransactionCard({
    Key? key,
    required this.index,
    required this.trxData,
    required this.dateData,
    required this.amountData,
    required this.postBalanceData,
    required this.detailsText,
    required this.expandIndex,
    required this.trxType,
    required this.transactionInfo,
  }) : super(key: key);

  @override
  _CustomTransactionCardState createState() => _CustomTransactionCardState();
}

class _CustomTransactionCardState extends State<CustomTransactionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = _parseDateString(widget.dateData);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    print("type ${widget.detailsText}");

    return GetBuilder<TransactionController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
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
            children: [
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Data',
              //       style: TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 17,
              //         color: Colors.black,
              //       ),
              //     ),
              //     Text(
              //       'Name',
              //       style: TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 17,
              //         color: Colors.black,
              //       ),
              //     ),
              //     Text(
              //       'Importo',
              //       style: TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 17,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 25,
                    child: CardColumn2(
                      alignmentEnd: true,
                      header: MyStrings.date.tr,
                      body: formattedDate.tr,
                      isDate: true,
                    ),
                  ),
                  widget.transactionInfo.type == null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Column(
                            children: [
                              Text(
                                  "${widget.transactionInfo.firstname!} ${widget.transactionInfo.lastname!}",
                                  style: interRegularDefault.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.smallTextColor1,
                                      fontSize: Dimensions.fontSmall)),
                              Text("${widget.transactionInfo.accountNumber}",
                                  style: interRegularDefault.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.smallTextColor1,
                                      fontSize: Dimensions.fontSmall)),
                            ],
                          ),
                      )
                      : Container(
                          // width: 100,
                          // height: 25,
                         padding: const EdgeInsets.only(right: 50.0, bottom: 8),
                          child: Text(
                            "${widget.transactionInfo.type}".tr,
                            style: interRegularDefault.copyWith(
                                fontStyle: FontStyle.italic,
                                color: MyColor.smallTextColor1,
                                fontSize: 12.0),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 8),
                    child: CardColumnForAmountText(
                      header: MyStrings.amount,
                      body: '${widget.amountData} ${controller.currency}',
                      textColor: controller.changeTextColor(widget.trxType),
                    ),
                  ),
                ],
              ),


              // const WidgetDivider(
              //   lineColor: MyColor.titleColor,
              //   space: Dimensions.space5,
              // ),


              if (isExpanded) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transazioni',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // Text(
                    //   MyStrings.balance.tr,
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 16,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Text(
                      MyStrings.details.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CardColumn2(header: MyStrings.trx, body: widget.trxData),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 50.0),
                //       child: Text(
                //         '${widget.postBalanceData} ${controller.currency}',
                //         style: interRegularDefault.copyWith(
                //             fontStyle: FontStyle.italic,
                //             color: MyColor.smallTextColor1,
                //             fontSize: Dimensions.fontSmall),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 15.0),
                //       child: Text(
                //         // MyStrings.details.tr,
                //         widget.detailsText,
                //         style: interRegularDefault.copyWith(
                //             fontStyle: FontStyle.italic,
                //             color: MyColor.smallTextColor1,
                //             fontSize: Dimensions.fontSmall),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130,
                      child: CardColumn2(header: MyStrings.trx, body: widget.trxData),
                    ),
                    const SizedBox(width: 10.0,),
                    // Container(
                    //   height: 30.0,
                    //   width: 60.0,
                    //   // color: Colors.red,
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     '${widget.postBalanceData} ${controller.currency}',
                    //     style: interRegularDefault.copyWith(
                    //         fontStyle: FontStyle.italic,
                    //         color: MyColor.smallTextColor1,
                    //         fontSize: Dimensions.fontSmall),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    Container(
                      child: Text(
                        // MyStrings.details.tr,
                        widget.detailsText.tr,
                        style: interRegularDefault.copyWith(
                            fontStyle: FontStyle.italic,
                            color: MyColor.smallTextColor1,
                            fontSize: Dimensions.fontSmall),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

              ],
            ],
          ),
        ),
      ),
    );
  }

  DateTime _parseDateString(String dateString) {
    List<String> parts = dateString.split(', ');
    String datePart = parts[0];
    String timePart = parts[1];
    timePart = timePart.replaceAll(',', '').trim();
    String combinedDateTime = '$datePart $timePart';
    DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
    return dateFormat.parse(combinedDateTime);
  }
}
