import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/util.dart';
import 'package:viser_bank/views/components/column/card_column.dart';
import 'package:viser_bank/views/components/status/status_widget.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';

class CustomDepositsCard extends StatelessWidget {

  final String trxValue, date,status, amount;
  final Color statusBgColor;
  final VoidCallback onPressed;

  const CustomDepositsCard({
    Key? key,
    required this.trxValue,
    required this.date,
    required this.status,
    required this.statusBgColor,
    required this.amount,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardColumn(
                  header: MyStrings.trxNo,
                  body: trxValue,
                ),
                CardColumnForAmountText(
                  header:MyStrings.amount.tr,
                  body: amount,
                  textColor: MyColor.green,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardColumn(
                  alignmentEnd: true,
                  header: MyStrings.date,
                  isDate: true,
                  body: date,
                ),
                StatusWidget(
                  needBorder: true,
                  status: status,
                  backgroundColor: statusBgColor,
                  borderColor: statusBgColor,
                )
              ],
            )


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CardColumn(
            //       header: MyStrings.trxNo,
            //       body: trxValue,
            //     ),
            //     CardColumn(
            //       alignmentEnd: true,
            //       header: MyStrings.date,
            //       isDate: true,
            //       body: date,
            //     ),
            //   ],
            // ),
            // const WidgetDivider(space: Dimensions.space10),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //
            //     CardColumn(
            //       header:MyStrings.amount.tr,
            //       body: amount,
            //     ),
            //     StatusWidget(
            //       needBorder: true,
            //       status: status,
            //       backgroundColor: statusBgColor,
            //       borderColor: statusBgColor,
            //     )
            //   ],
            // ),
          ],
        )
      ),
    );
  }
}
