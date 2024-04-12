import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/date_converter.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/data/controller/home/home_controller.dart';
import 'package:viser_bank/views/components/no_data/no_data_found.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';
import 'package:viser_bank/views/screens/home/widget/latest_transaction_list_item.dart';
import 'package:viser_bank/views/screens/home/widget/top_buttons.dart';

import 'latest_transaction.dart';

class HomeScreenItemsSection extends StatefulWidget {

  const HomeScreenItemsSection({Key? key}) : super(key: key);

  @override
  State<HomeScreenItemsSection> createState() => _HomeScreenItemsSectionState();
}

class _HomeScreenItemsSectionState extends State<HomeScreenItemsSection> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.only(top: 25.0),
        decoration: BoxDecoration(
            color: MyColor.getCardBg(),
        ),
        child: const TopButtons(),
        // child: const SingleChildScrollView(
        //   padding: EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       TopButtons(),
        //       // const WidgetDivider(space: 20,),
        //       // const LatestTransaction(),
        //       // controller.debitsLists.isEmpty ? const NoDataWidget(topMargin: 60) : ListView.builder(
        //       //   scrollDirection: Axis.vertical,
        //       //   physics: const NeverScrollableScrollPhysics(),
        //       //   padding: EdgeInsets.zero,
        //       //   shrinkWrap: true,
        //       //   itemCount: controller.debitsLists.length,
        //       //   itemBuilder: (context, index) => LatestTransactionListItem(
        //       //     isShowDivider:true,
        //       //     isCredit:controller.debitsLists[index].trxType=='+'?true:false,
        //       //     trx: controller.debitsLists[index].trx ?? "",
        //       //     date: '${DateConverter.isoStringToLocalDateOnly(controller.debitsLists[index].createdAt ?? "")}, ${DateConverter.isoStringToLocalTimeOnly(controller.debitsLists[index].createdAt ?? "")}',
        //       //     amount: "${controller.currencySymbol}${Converter.formatNumber(controller.debitsLists[index].amount ?? "")}",
        //       //     postBalance: "${Converter.formatNumber(controller.debitsLists[index].postBalance ?? "")} ${controller.currency}",
        //       //     onPressed: (){},
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
