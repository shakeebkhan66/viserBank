import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/views/components/row_item/form_row.dart';

class LabelText1 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final bool required;

  const LabelText1({
    Key? key,
    required this.text,
    this.textAlign,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required
        ? FormRow(label: text.tr, isRequired: true)
        : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            MyColor.primaryColor.withOpacity(0.8),
            MyColor.titleColor.withOpacity(0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0.4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          text.tr,
          textAlign: textAlign,
          style: interRegularDefault.copyWith(
            color: Colors.white, // Text color
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            fontSize: Dimensions.fontLarge,
          ),
        ),
      ),
    );
  }
}
