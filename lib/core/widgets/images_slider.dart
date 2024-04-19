// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:posts_app/core/model/user.dart';
// import 'package:posts_app/core/utils/helpers.dart';
// import 'package:collection/collection.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:posts_app/core/utils/util_values.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import '../bottom_sheets/select_branch_bottom_sheet/select_branch_bottom_sheet.dart';
// import '../controller/user_provider.dart';
// import '../generated/locale_keys.g.dart';
// import '../model/banner.dart';
// import '../screens/item_details_screen/item_details_screen.dart';
// import '../screens/main_screen/main_screen.dart';
// import '../screens/vouchers_screen/vouchers_screen.dart';
// import '../services/http/apis/miscellaneous_api.dart';
// import '../services/http/interceptors/api_interceptor.dart';
// import '../utils/colors_palette.dart';
// import '../utils/size_config.dart';
// import '../utils/snackbars.dart';
//
// class ImagesSlider extends StatelessWidget {
//   final List<DataEn> imagesUrls;
//   final List<DataAr> imagesUrlsAr;
//   ImagesSlider({Key? key, required this.imagesUrls, required this.imagesUrlsAr}) : super(key: key);
//
//   CarouselController carouselController = CarouselController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 90.w,
//       height: 15.h,
//       child: ClipRRect(
//         borderRadius: UtilValues.borderRadius10,
//         child: CarouselSlider.builder(
//           itemCount: Helpers.isEnglish(context) ? imagesUrls.length : imagesUrlsAr.length,
//           carouselController: carouselController,
//           //itemCount: imagesUrls.length /*Helpers.isEnglish(context) ? imagesUrls.map((e) => e.bannerEn).length : imagesUrls.map((e) => e.bannerAr).length*/,
//           options: CarouselOptions(
//             viewportFraction: 1,
//             aspectRatio: 16 / 9,
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlay: true,
//             autoPlayAnimationDuration: const Duration(milliseconds: 500),
//           ),
//           itemBuilder: (BuildContext context, int index, int realIndex) {
//             return GestureDetector(
//               onTap: (){
//                 if(index == 0){
//                   final userProvider = context.read<UserProvider>();
//                     if(userProvider.isLoggedIn){
//                       Navigator.pushNamed(context, VouchersScreen.routeName);
//                     } else {
//                       Navigator.of(context).pushNamed(LoginScreen.routeName);
//                     }
//                 } else if(index == 1 ){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MainScreen(index: 1, categoryId: 0,)),
//                   );
//                 } else if (selectedBranch == 0 && activeButton == 1) {
//                   showSnackbar(context: context, status: SnackbarStatus
//                       .info, message: 'Please Select branch');
//                   SelectBranchBottomSheet.show(context);
//                 }
//                 else {
//                   Navigator.of(context).pushNamed(ItemDetailsScreen.routeName, arguments: imagesUrls[index].id);
//                 }
//               },
//               child: CachedNetworkImage(  errorWidget: (context, url, error) => Container(height: 150.0, child: Icon(Icons.error),),
//                 height: 15.h,
//                 imageUrl: Helpers.isEnglish(context) ? imagesUrls[index].bannerEn ?? '' : imagesUrlsAr[index].bannerAr ?? '',
//                 fit: BoxFit.fill,
//                 width: double.infinity,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
