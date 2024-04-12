import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';



class CustomDropDownTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  const CustomDropDownTextField({Key? key,
    this.title,
    this.selectedValue,
    this.list,
    this.onChanged, }) : super(key: key);

  @override
  State<CustomDropDownTextField> createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    widget.list?.removeWhere((element) => element.isEmpty);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:45,
            decoration: BoxDecoration(
                color: MyColor.getCardBg(),
                borderRadius:const  BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: MyColor.getBorderColor())
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left:10,
                  right: 5,
                  top: 5,
                  bottom: 5
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                hint: Text(
                  widget.selectedValue??'',
                  style:interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
                ), // Not necessary for Option 1
                value: widget.selectedValue,
                dropdownColor: Colors.cyan.shade100,
                onChanged: widget.onChanged,
                icon: const Icon(Icons.arrow_drop_down,color: MyColor.colorGrey,),
                items: widget.list!.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.tr,
                      style: interRegularDefault.copyWith(color: MyColor.titleColor, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
