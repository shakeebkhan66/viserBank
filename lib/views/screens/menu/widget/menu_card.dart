import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';

class MenuCard extends StatelessWidget {
  final Widget child;
  const MenuCard({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(Dimensions.space15),
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: MyColor.smallTextColor2,
          offset: Offset(0.1, 0.0),
          blurRadius: 2,
          spreadRadius: 0.1
        )
      ],
      color: MyColor.getCardBg(),
      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
    child: child,
    );
  }
}
