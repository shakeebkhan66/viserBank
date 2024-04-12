import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_icons.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/alert-dialog/exit_dialog.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//
//   final String title;
//   final bool isShowBackBtn;
//   final bool isShowActionBtn;
//   final bool isTitleCenter;
//   final bool fromAuth;
//   final bool isProfileCompleted;
//   final String actionText;
//   final IconData actionIcon;
//   final VoidCallback? press;
//   final bool isActionIconAlignEnd;
//   final Color bgColor;
//   final bool isForceBackHome;
//
//
//   const CustomAppBar(
//       {Key? key,
//       this.isProfileCompleted = false,
//       this.fromAuth = false,
//       this.isTitleCenter = false,
//       this.isShowBackBtn = true,
//       required this.title,
//       this.actionText = '',
//       this.actionIcon= Icons.format_list_bulleted,
//       this.press,
//       this.bgColor = MyColor.primaryColor,
//       this.isActionIconAlignEnd = false,
//       this.isForceBackHome = false,
//       this.isShowActionBtn = false})
//       : super(key: key);
//
//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
//
//   @override
//   Size get preferredSize => const Size(double.maxFinite, 50);
// }
//
// class _CustomAppBarState extends State<CustomAppBar> {
//   bool hasNotification = false;
//
//   @override
//   void initState() {
//     Get.put(ApiClient(sharedPreferences: Get.find()));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.isShowBackBtn
//         ? AppBar(
//             systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarColor: MyColor.primaryColor.withOpacity(0.8),
//                 statusBarIconBrightness: Brightness.light,
//                 systemNavigationBarColor: MyColor.navigationBarColor,
//                 systemNavigationBarIconBrightness: Brightness.dark),
//             elevation: 0,
//             leading: widget.isShowBackBtn
//                 ? IconButton(
//                     onPressed: () {
//                       if (widget.fromAuth) {
//                         Get.offAllNamed(RouteHelper.loginScreen);
//                       } else if (widget.isProfileCompleted) {
//                         showExitDialog(Get.context!);
//                       } else {
//                         String previousRoute = Get.previousRoute;
//                         if (previousRoute == '/splash-screen' || widget.isForceBackHome == true) {
//                           Get.offAndToNamed(RouteHelper.homeScreen);
//                         } else {
//                           Get.back();
//                         }
//                       }
//                     },
//                     icon: const Icon(Icons.arrow_back_ios,
//                         color: MyColor.colorWhite, size: 16))
//                 : const SizedBox.shrink(),
//             backgroundColor: widget.bgColor,
//             title: Text(widget.title.tr,
//                 style: interRegularLarge.copyWith(color: MyColor.colorWhite, letterSpacing: 0.5, fontSize: 17)),
//             centerTitle: widget.isTitleCenter,
//             actions: [
//               widget.isShowActionBtn
//                   ?GestureDetector(
//                 onTap: widget.press,
//                 child: Container(
//                   margin: const EdgeInsetsDirectional.only(end: 7,bottom: 7,top: 7),
//                   padding: const EdgeInsets.all(Dimensions.space7),
//                   decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
//                   child:  Icon(widget.actionIcon, color: MyColor.primaryColor, size: 15),
//                 ),
//               ) : const SizedBox.shrink(),
//               const SizedBox(
//                 width: 10,
//               )
//             ],
//           )
//         : AppBar(
//             systemOverlayStyle: const SystemUiOverlayStyle(
//                 statusBarColor: MyColor.primaryColor,
//                 statusBarIconBrightness: Brightness.light,
//                 systemNavigationBarColor: MyColor.navigationBarColor,
//                 systemNavigationBarIconBrightness: Brightness.dark),
//             elevation: 0,
//             backgroundColor: MyColor.primaryColor.withOpacity(0.8),
//             title: Text(widget.title.tr,
//                 style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
//             actions: [
//               widget.isShowActionBtn
//                   ? InkWell(
//                       onTap: () {
//                         Get.toNamed(RouteHelper.notificationScreen)
//                             ?.then((value) {
//                           setState(() {
//                             hasNotification = false;
//                           });
//                         });
//                       },
//                       child: SvgPicture.asset(
//                         hasNotification
//                             ? MyIcons.activeNotificationIcon
//                             : MyIcons.inActiveNotificationIcon,
//                         height: 28,
//                         width: 28,
//                       ))
//                   : const SizedBox.shrink(),
//               const SizedBox(width: 10)
//             ],
//             automaticallyImplyLeading: false,
//           );
//   }
// }



class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackBtn;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final String actionText;
  final IconData actionIcon;
  final VoidCallback? press;
  final bool isActionIconAlignEnd;
  final Color bgColor;
  final bool isForceBackHome;

  const CustomAppBar({
    Key? key,
    this.isProfileCompleted = false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.isShowBackBtn = true,
    required this.title,
    this.actionText = '',
    this.actionIcon = Icons.format_list_bulleted,
    this.press,
    this.bgColor = MyColor.primaryColor,
    this.isActionIconAlignEnd = false,
    this.isForceBackHome = false,
    this.isShowActionBtn = false,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification = false;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      child: widget.isShowBackBtn
          ? AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.primaryColor.withOpacity(0.8), // Set status bar color here
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        leading: widget.isShowBackBtn
            ? IconButton(
          onPressed: () {
            if (widget.fromAuth) {
              Get.offAllNamed(RouteHelper.loginScreen);
            } else if (widget.isProfileCompleted) {
              showExitDialog(Get.context!);
            } else {
              String previousRoute = Get.previousRoute;
              if (previousRoute == '/splash-screen' ||
                  widget.isForceBackHome == true) {
                Get.offAndToNamed(RouteHelper.homeScreen);
              } else {
                Get.back();
              }
            }
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: MyColor.colorWhite, size: 16),
        )
            : const SizedBox.shrink(),
        backgroundColor: MyColor.primaryColor.withOpacity(0.8),
        title: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Center(
            child: Text(
              widget.title.tr,
              style: interRegularLarge.copyWith(
                  color: MyColor.colorWhite,
                  letterSpacing: 0.5,
                  fontSize: 17),
            ),
          ),
        ),
        centerTitle: widget.isTitleCenter,
        actions: [
          widget.isShowActionBtn
              ? GestureDetector(
            onTap: widget.press,
            child: Container(
              margin: const EdgeInsetsDirectional.only(
                  end: 7, bottom: 7, top: 7),
              padding: const EdgeInsets.all(Dimensions.space7),
              decoration: const BoxDecoration(
                  color: MyColor.colorWhite,
                  shape: BoxShape.circle),
              child: Icon(widget.actionIcon,
                  color: MyColor.primaryColor, size: 15),
            ),
          )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 10,
          )
        ],
      )
          : AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.primaryColor.withOpacity(0.8), // Set status bar color here
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.primaryColor.withOpacity(0.8), // Adjust as needed
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: MyColor.primaryColor.withOpacity(0.8),
        title: Text(
          widget.title.tr,
          style: interRegularLarge.copyWith(color: MyColor.colorWhite),
        ),
        actions: [
          widget.isShowActionBtn
              ? InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.notificationScreen)
                    ?.then((value) {
                  setState(() {
                    hasNotification = false;
                  });
                });
              },
              child: SvgPicture.asset(
                hasNotification
                    ? MyIcons.activeNotificationIcon
                    : MyIcons.inActiveNotificationIcon,
                height: 28,
                width: 28,
              ))
              : const SizedBox.shrink(),
          const SizedBox(width: 10)
        ],
        automaticallyImplyLeading: false,
      ),
    );
  }
}


