import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';

class CardColumn extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;

  const CardColumn(
      {Key? key,
      this.alignmentEnd = false,
      required this.header,
      this.isDate = false,
      this.textColor,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment:
      //     alignmentEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(header.tr,style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
        const SizedBox(
          height: 8,
        ),
        Text(body.tr,
            style: isDate
                ? interRegularDefault.copyWith(
                    fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                    color: textColor ?? MyColor.smallTextColor1,
                    fontSize: Dimensions.fontSmall)
                : interRegularDefault.copyWith(
                fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: textColor ?? MyColor.smallTextColor1))
      ],
    );
  }
}


class CardColumnForAmountText extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;

  const CardColumnForAmountText(
      {Key? key,
        this.alignmentEnd = false,
        required this.header,
        this.isDate = false,
        this.textColor,
        required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment:
      //     alignmentEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(header.tr,style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(body.tr,
              style: isDate
                  ? interRegularDefault.copyWith(
                  fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.bold,
                  color: textColor ?? MyColor.smallTextColor1,
                  fontSize: Dimensions.fontSmall)
                  : interRegularDefault.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: textColor ?? MyColor.smallTextColor1)),
        ),
      ],
    );
  }
}
class CardColumn2 extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;

  const CardColumn2(
      {Key? key,
        this.alignmentEnd = false,
        required this.header,
        this.isDate = false,
        this.textColor,
        required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment:
      //     alignmentEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(header.tr,style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
        const SizedBox(
          height: 0,
        ),
        Text(body.tr,
            style: isDate
                ? interRegularDefault.copyWith(
                fontStyle: FontStyle.italic,
                // fontWeight: FontWeight.bold,
                color: textColor ?? MyColor.smallTextColor1,
                fontSize: 12.0)
                : interRegularDefault.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: textColor ?? MyColor.titleColor.withOpacity(0.6)))
      ],
    );
  }
}
