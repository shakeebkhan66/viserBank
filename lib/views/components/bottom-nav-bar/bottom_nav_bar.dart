import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_images.dart';
import 'package:viser_bank/core/utils/my_strings.dart';


class CustomBottomNav extends StatefulWidget {

  final int currentIndex;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  var bottomNavIndex;

  List<String> iconList = [MyImages.homeIcon, MyImages.transferIcon2, MyImages.transactionIcon, MyImages.menuIcon];
  final textList = [MyStrings.home, MyStrings.transfer,MyStrings.transaction, MyStrings.menu];

  @override
  void initState() {

    print("Hello ${widget.currentIndex}");

    widget.currentIndex != null ?  bottomNavIndex = widget.currentIndex : 0;
    // bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedBottomNavigationBar.builder(
    //   height: 65,
    //   elevation: 10,
    //   itemCount: iconList.length,
    //   tabBuilder: (int index, bool isActive) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SvgPicture.asset(
    //           iconList[index],
    //           height: 18, width: 18,
    //           color: isActive ? MyColor.primaryColor : MyColor.colorGrey,
    //         ),
    //         const SizedBox(height: Dimensions.space5),
    //         Text(
    //             textList[index].tr,
    //             style: interRegularExtraSmall.copyWith(color: isActive ? MyColor.primaryColor : MyColor.colorGrey,fontSize: Dimensions.fontSmall)
    //         )
    //       ],
    //     );
    //   },
    //   backgroundColor: MyColor.primaryColor,
    //   gapLocation: GapLocation.none,
    //   leftCornerRadius: 0,
    //   rightCornerRadius: 0,
    //   onTap: (index) {
    //     _onTap(index);
    //   },
    //   activeIndex: bottomNavIndex,
    // );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ],
      ),
      child: Container(
        color: MyColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: GNav(
            padding: const EdgeInsets.all(10),
            backgroundColor: MyColor.primaryColor,
            color: MyColor.colorWhite,
            activeColor: MyColor.colorWhite,
            tabBackgroundColor: MyColor.colorWhite.withOpacity(0.4),
            rippleColor: Colors.cyan,
            haptic: true, // haptic feedback
            tabBorderRadius: 30,
            gap: 2,
            curve: Curves.easeOutExpo, // tab animation curves
            duration: const Duration(milliseconds: 200),
            selectedIndex: bottomNavIndex,
            onTabChange: (index) {
              _onTap(index);
            },
            tabs: const [
              GButton(icon: Icons.home, iconColor: MyColor.colorWhite, text: 'Home',),
              GButton(icon: Icons.swap_horiz, iconColor: MyColor.colorWhite, text: 'Invia KMoney'),
              GButton(icon: Icons.swap_horiz, iconColor: MyColor.colorWhite, text: 'Transazioni',),
              GButton(icon: Icons.widgets_outlined, iconColor: MyColor.colorWhite, text: 'Menu',)
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    int currentIndex = widget.currentIndex ?? 0;
    if (index == 0) {
      if (!(currentIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }
    else if (index == 1) {
      if (!(currentIndex == 1)) {
        Get.toNamed(RouteHelper.myBankTransferScreen);
      }
    }
    else if (index == 2) {
      if (!(currentIndex == 2)) {
        Get.offAndToNamed(RouteHelper.transactionScreen);
      }
    }
    else if (index == 3) {
      if (!(currentIndex== 3)) {
        Get.offAndToNamed(RouteHelper.menuScreen);
      }
    }
  }

}



