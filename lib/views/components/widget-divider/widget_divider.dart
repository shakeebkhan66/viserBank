import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';

class WidgetDivider extends StatelessWidget {
  final double space;
  final Color? lineColor;

  const WidgetDivider({
    Key? key,
    this.lineColor,
    this.space = Dimensions.space20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: space),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 1, // Blur radius
                offset: const Offset(0, 0.2), // Shadow offset
              ),
            ],
          ),
        ),
        SizedBox(height: space),
      ],
    );
  }
}
