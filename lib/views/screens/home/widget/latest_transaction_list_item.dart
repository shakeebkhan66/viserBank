// import 'package:flutter/material.dart';
// import 'package:viser_bank/core/utils/dimensions.dart';
// import 'package:viser_bank/core/utils/my_color.dart';
// import 'package:viser_bank/core/utils/style.dart';
// import 'package:viser_bank/views/components/divider/custom_divider.dart';
//
// class LatestTransactionListItem extends StatelessWidget {
//
//   final String trx;
//   final String date;
//   final String amount;
//   final String postBalance;
//   final String currency;
//   final VoidCallback onPressed;
//   final bool isShowDivider;
//   final bool isCredit;
//
//   const LatestTransactionListItem({
//     Key? key,
//     required this.onPressed,
//     required this.isCredit,
//     required this.trx,
//     required this.date,
//     required this.amount,
//     required this.postBalance,
//     this.isShowDivider = false,
//     this.currency = ''
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//           onTap: onPressed,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration:  BoxDecoration(color: MyColor.transparentColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                          Container(
//                 height: 35, width: 35,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: isCredit?MyColor.greenSuccessColor.withOpacity(0.17):MyColor.colorRed.withOpacity(0.2),
//                     shape: BoxShape.circle
//                 ),
//                 child: Icon(
//                   isCredit?Icons.arrow_downward:Icons.arrow_upward,
//                   color:  isCredit?MyColor.greenSuccessColor: MyColor.colorRed,
//                   size: 20,
//                 )
//             ),
//                         const SizedBox(width: Dimensions.space12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(trx,
//                               style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
//                             ),
//                             const SizedBox(height: Dimensions.space10),
//                             SizedBox(
//                               width: 150,
//                               child: Text(
//                                 date,
//                                 style: interRegularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.5)),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                     Flexible(
//                       child: Text(
//                           amount,
//                           overflow: TextOverflow.ellipsis,
//                           style: interRegularDefault.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600)
//                       ),
//                     )
//                   ],
//                 ),
//                 isShowDivider?
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Dimensions.space5),
//                   child:  CustomDivider(space: 20,borderColor: MyColor.bgColor1,),
//                 ): const SizedBox(height: Dimensions.space20)
//               ],
//             ),
//           )
//       );
//   }
// }


import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/views/components/divider/custom_divider.dart';

class LatestTransactionListItem extends StatelessWidget {
  final String trx;
  final String date;
  final String amount;
  final String postBalance;
  final String currency;
  final VoidCallback onPressed;
  final bool isShowDivider;
  final bool isCredit;

  const LatestTransactionListItem({
    Key? key,
    required this.onPressed,
    required this.isCredit,
    required this.trx,
    required this.date,
    required this.amount,
    required this.postBalance,
    this.isShowDivider = false,
    this.currency = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isCredit ? Colors.cyan.shade50 : Colors.white, // Adjust card color
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isCredit
                          ? MyColor.greenSuccessColor.withOpacity(0.17)
                          : MyColor.colorRed.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isCredit ? MyColor.greenSuccessColor : MyColor.colorRed,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: Dimensions.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trx,
                          style: interRegularDefault.copyWith(
                            color: MyColor.getTextColor(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          date,
                          style: interRegularSmall.copyWith(
                            color: MyColor.getTextColor().withOpacity(0.5),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    amount,
                    overflow: TextOverflow.ellipsis,
                    style: interRegularDefault.copyWith(
                      color: isCredit ? Colors.green : Colors.red, // Adjust text color based on transaction type
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
