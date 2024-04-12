// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:viser_bank/core/utils/dimensions.dart';
// import 'package:viser_bank/data/controller/home/home_controller.dart';
//
// class TopButtons extends StatefulWidget {
//   const TopButtons({Key? key}) : super(key: key);
//
//   @override
//   State<TopButtons> createState() => _TopButtonsState();
// }
//
// class _TopButtonsState extends State<TopButtons> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(builder: (controller) {
//       return controller.moduleList.length == 8
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(child: controller.moduleList[0]),
//                     if (controller.userType == 'agent')
//                       Expanded(child: controller.moduleList[1]),
//                     Expanded(child: controller.moduleList[2]),
//                     Expanded(child: controller.moduleList[3]),
//                   ],
//                 ),
//                 const SizedBox(height: Dimensions.space20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(child: controller.moduleList[4]),
//                     Expanded(child: controller.moduleList[5]),
//                     Expanded(child: controller.moduleList[6]),
//                     Expanded(child: controller.moduleList[7]),
//                   ],
//                 )
//               ],
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 controller.moduleList.length > 4
//                     ? Wrap(
//                         spacing: 8.0,
//                         runSpacing: 8.0,
//                         children: [
//                           ...controller.moduleList
//                               .getRange(0, 4)
//                               .map((item) => SizedBox(
//                                     width: (MediaQuery.of(context).size.width -
//                                             32 -
//                                             24) /
//                                         4,
//                                     // 32 is the total horizontal padding, 24 is the total horizontal spacing
//                                     child: item,
//                                   ))
//                               .toList(),
//                           ...controller.moduleList
//                               .getRange(4, controller.moduleList.length)
//                               .map((item) => SizedBox(
//                                     width: (MediaQuery.of(context).size.width -
//                                             32 -
//                                             24) /
//                                         4,
//                                     child: item,
//                                   ))
//                               .toList(),
//                         ],
//                       )
//                     : controller.moduleList.length == 4
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(child: controller.moduleList[0]),
//                               Expanded(child: controller.moduleList[1]),
//                               Expanded(child: controller.moduleList[2]),
//                               Expanded(child: controller.moduleList[3]),
//                             ],
//                           )
//                         : Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(child: controller.moduleList[0]),
//                               Expanded(child: controller.moduleList[1]),
//                               Expanded(
//                                 child: controller.moduleList.length == 3
//                                     ? controller.moduleList[2]
//                                     : const SizedBox(),
//                               ),
//                               const Expanded(
//                                 child: SizedBox(),
//                               ),
//                             ],
//                           ),
//               ],
//             );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/home/home_controller.dart';
import '../../../../model/module_model.dart';
import '../../transfer/pay_with_%.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: MyColor.transparentColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: controller.moduleList.asMap().entries.map<Widget>((entry) {
              final int index = entry.key;
              final Module module = entry.value;
              // Skip index 1 (or any other index) using a condition
              if (index != 1 && index != 4) {
                return _buildButton(module, Colors.green);
              } else {
                return const SizedBox.shrink();
              }
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildButton(Module module, Color color) {
    return GestureDetector(
      onTap: () {
        print("button ${module.buttonText}");
        _handleButtonTap(module.buttonText);
      },
      child: Container(
        height: 60,
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.cyan.shade50,
              Colors.cyan.shade50
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
          border: Border.all(
            color: Colors.greenAccent.shade100,
            width: 0.5,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 0.4), // changes position of shadow
          //   ),
          // ],
          // gradient: LinearGradient(
          //   begin: Alignment.center,
          //   end: Alignment.center,
          //   colors: [
          //     MyColor.colorWhite,
          //     Colors.blueGrey.withOpacity(0.4),
          //   ],
          //
          // ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            module.buttonText.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Image.asset(
          //       module.iconData,
          //       color: Colors.white,
          //       height: 20,
          //       width: 20,
          //     ),
          //
          //   ],
          // ),
        ),
      ),
    );
  }

  void _handleButtonTap(String buttonText) {
    switch (buttonText) {
      case MyStrings.deposit:
        Get.toNamed(RouteHelper.newDepositScreenScreen);
        break;
      case MyStrings.fdr:
        Get.toNamed(RouteHelper.fdrScreen);
        break;
      case MyStrings.dps:
        Get.toNamed(RouteHelper.dpsScreen);
        break;
      case MyStrings.loan:
        Get.toNamed(RouteHelper.loanScreen);
        break;
      case MyStrings.withdrawal:
        Get.toNamed(RouteHelper.withdrawScreen);
        break;
      case MyStrings.transfer:
        Get.toNamed(RouteHelper.myBankTransferScreen);
        break;
      case MyStrings.transaction:
        Get.toNamed(RouteHelper.transactionScreen);
        break;
      case MyStrings.referral:
        Get.toNamed(RouteHelper.referralScreen);
        break;
      case MyStrings.paymentRequest:
        Get.to(() => const PaymentWithPercentage());
        break;
      case MyStrings.stores:
        _launchURL(urlLink: 'https://kosmomoney.com/user/store/store-list');
        break;
      default:
      // Handle default case
        break;
    }
  }


  void _launchURL({required String urlLink}) async {
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    } else {
      throw 'Could not launch $urlLink';
    }
  }
}




