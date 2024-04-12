import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/views/components/buttons/custom_circle_animated_button.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';

class BottomSheetTopRow extends StatelessWidget {
  final String header;
  final double bottomSpace;
  final Color bgColor;
  const BottomSheetTopRow({
    Key? key,
    required this.header,
    this.bottomSpace = 10,
    this.bgColor = MyColor.containerBgColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(header.tr, style: interRegularLarge.copyWith(fontWeight: FontWeight.w600)),
            CustomCircleAnimatedButton(
              press: (){
                Get.back();
              },
              height: 30,
              width: 30,
              backgroundColor: MyColor.titleColor,
              child:  const Icon(Icons.clear, color: Colors.white, size: 15),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: WidgetDivider(
            lineColor: MyColor.titleColor,
            space: bottomSpace,
          ),
        ),
      ],
    );
  }
}
