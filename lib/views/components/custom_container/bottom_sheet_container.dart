import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/my_color.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final bool showBorder;

  const BottomSheetContainer(
      {Key? key, required this.child, this.showBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showBorder
        ? Container(
      padding: const EdgeInsets.all(12),
      // margin: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.titleColor,
                border: Border.all(color: MyColor.borderColor)),
            child: child,
          )
        : Container(
            padding: const EdgeInsets.all(12),
            // margin: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.titleColor,
                border: Border.all(color: MyColor.colorWhite.withOpacity(0.3))),
            child: child,
          );
  }
}
