import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/core/utils/url.dart';
import 'package:viser_bank/data/controller/home/home_controller.dart';
import 'package:viser_bank/views/components/circle_widget/circle_image_button.dart';

import 'balance_animated_app_bar.dart';

class HomeScreenTop extends StatefulWidget {
  const HomeScreenTop({Key? key}) : super(key: key);

  @override
  State<HomeScreenTop> createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0,),
                      CircleImageWidget(
                        height: 90,
                        width: 90,
                        isProfile:true,
                        isAsset: false,
                        imagePath: '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                        press: (){
                           Get.toNamed(RouteHelper.profileScreen);
                        },),
                      const SizedBox(height: 15.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(controller.username, textAlign: TextAlign.left, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontSize: 20.0 , fontWeight: FontWeight.w700, letterSpacing: 1.0),),
                          const SizedBox(height: Dimensions.space5),
                          Text(controller.accountNumber, textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, color: MyColor.colorWhite.withOpacity(.7), fontWeight: FontWeight.w500, letterSpacing: 1.0)),
                          const SizedBox(height: Dimensions.space10),
                          // Text("Current Balance", textAlign: TextAlign.left, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w700, fontSize: 20, letterSpacing: 1.0),),
                          const SizedBox(height: Dimensions.space10),
                          SizedBox(width:180,child: BalanceAnimationContainer(amount: controller.bothBalance.toString(),curSymbol: controller.currencySymbol,)),
                          const SizedBox(height: 30.0,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(width: 10,),
              // const Spacer(),
              // SizedBox(width:120,child: BalanceAnimationContainer(amount: controller.bothBalance.toString(),curSymbol: controller.currencySymbol,)),
            ],
          ),
        ],
      ),
    );
  }
}