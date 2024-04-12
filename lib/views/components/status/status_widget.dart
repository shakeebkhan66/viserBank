import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';

class StatusWidget extends StatelessWidget {

  final String status;
  final Color foregroundColor;
  final Color? backgroundColor;
  final Color borderColor;
  final bool needBorder;

  const StatusWidget({
    Key? key,
    required this.status,
    this.foregroundColor = MyColor.primaryColor,
    this.backgroundColor,
    this.borderColor = MyColor.primaryColor,
    this.needBorder = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return needBorder ? Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        color: MyColor.transparentColor,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        border: Border.all(color: borderColor, width: 1.0)
      ),
      child: Text(status.tr, textAlign: TextAlign.center,  style: interRegularExtraSmall.copyWith(fontSize: 14.0, color: borderColor)),
    ) : Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      ),
      child: Text(status.tr, textAlign: TextAlign.center, style: interRegularExtraSmall.copyWith(color: foregroundColor)),
    );
  }
}

