// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:viser_bank/core/utils/dimensions.dart';
// import 'package:viser_bank/core/utils/my_color.dart';
// import 'package:viser_bank/data/controller/home/home_controller.dart';
// import 'package:viser_bank/data/repo/home/home_repo.dart';
// import 'package:viser_bank/data/services/api_service.dart';
// import 'package:viser_bank/views/components/bottom-nav-bar/bottom_nav_bar.dart';
// import 'package:viser_bank/views/components/custom_loader.dart';
// import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
// import 'package:viser_bank/views/components/will_pop_widget.dart';
// import 'package:viser_bank/views/screens/home/widget/home_screen_items_section.dart';
// import 'package:viser_bank/views/screens/home/widget/home_screen_top.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   void initState() {
//
//     super.initState();
//     Get.put(ApiClient(sharedPreferences: Get.find()));
//     Get.put(HomeRepo(apiClient: Get.find()));
//     final controller = Get.put(HomeController(repo: Get.find()));
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//
//       controller.loadData();
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       builder: (controller) => WillPopWidget(
//         nextRoute: '',
//         child: SafeArea(
//           child: Scaffold(
//               backgroundColor: MyColor.colorWhite,
//               body: controller.isLoading ? const CustomLoader() : controller.noInternet?
//               NoDataFoundScreen(
//                 isNoInternet: true,
//                 press:(value){
//                   if(value){
//                     controller.changeNoInternetStatus(false);
//                     controller.loadData();
//                   }
//                   },
//               ) :SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: RefreshIndicator(color: MyColor.primaryColor,
//                   backgroundColor: MyColor.colorWhite,
//                   onRefresh: () async {
//                     await controller.loadData();
//                   },
//                   child: CustomScrollView(
//                   controller: scrollController,
//                   physics: const ClampingScrollPhysics(),
//                   slivers: [
//                     SliverAppBar(
//                       pinned: false,
//                       elevation: 0,
//                       automaticallyImplyLeading: false,
//                       backgroundColor:  MyColor.primaryColor.withOpacity(0.8),
//                       expandedHeight: 310,
//                       shape: const ContinuousRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(85.0), // Adjust the radius as needed
//                           bottomRight: Radius.circular(85.0), // Adjust the radius as needed
//                         ),
//                       ),
//                       flexibleSpace:  FlexibleSpaceBar(
//                       background: Container(
//                           padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20),
//                           child: const HomeScreenTop(),
//                         ),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: MyColor.colorWhite,
//                         ),
//                         child: const HomeScreenItemsSection()
//                       )
//                     )
//                   ],
//             ),
//                 ),
//               ),
//             bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/data/controller/home/home_controller.dart';
import 'package:viser_bank/data/repo/home/home_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/home/widget/home_screen_items_section.dart';
import 'package:viser_bank/views/screens/home/widget/home_screen_top.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(HomeController(repo: Get.find()));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.colorWhite,
            body: controller.isLoading
                ? const CustomLoader()
                : controller.noInternet
                ? NoDataFoundScreen(
              isNoInternet: true,
              press: (value) {
                if (value) {
                  controller.changeNoInternetStatus(false);
                  controller.loadData();
                }
              },
            )
                : Column(
              children: [
                PreferredSize(
                  preferredSize: const Size.fromHeight(310),
                  child: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColor.primaryColor.withOpacity(0.8),
                        ),
                        padding: const EdgeInsets.only(
                            left: Dimensions.space15,
                            right: Dimensions.space15,
                            top: Dimensions.space20),
                        child: const HomeScreenTop(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColor.colorWhite,
                    ),
                    child: const HomeScreenItemsSection(),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

// Custom Clipper for AppBar shape
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, size.height); // Start from bottom-left
    path.lineTo(0, size.height - 30); // Line to top-left
    path.quadraticBezierTo(0, size.height, 30, size.height); // Curve to top-left corner
    path.lineTo(size.width - 30, size.height); // Line to top-right
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 30); // Curve to top-right corner
    path.lineTo(size.width, 0); // Line to bottom-right
    path.lineTo(0, 0); // Line to bottom-left (closing the path)
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


