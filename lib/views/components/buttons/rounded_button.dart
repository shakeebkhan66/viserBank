import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Color borderColor;

  const RoundedButton({
    Key? key,
    this.width=1,
    this.cornerRadius=6,
    required this.text,
    required this.press,
    this.isOutlined=false,
    this.horizontalPadding=35,
    this.verticalPadding=18,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
    this.borderColor = MyColor.borderColor,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isOutlined? Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: press,
        splashColor: MyColor.transparentColor,
        child: Container(
            padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            width: size.width * width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                border: Border.all(color: borderColor),
                color: Colors.transparent
            ),
            child: Center(child: Text(text.tr,style:TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w500)))),
      ),
    ): SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            textStyle: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w500),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cornerRadius),
              gradient: const LinearGradient(
                colors: [
                  MyColor.primaryColor,
                  MyColor.titleColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Center(
              child: Text(
                text.tr,
                maxLines: 1,
                style: interRegularDefaultText.copyWith(color: textColor),
              ),
            ),
          ),
        ),

      ),
    );
  }
}