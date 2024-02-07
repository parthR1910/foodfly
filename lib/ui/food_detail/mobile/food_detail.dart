import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/controller/food_controller/food_controlller.dart';
import 'package:food_fly/framework/data/providers/quantity_state_provider.dart';
import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/food_detail/mobile/helper/delete_food_bottom_sheet.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import '../../../framework/model/food_data_model/food_data_model.dart';
import '../../utils/common_device_config.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_routes.dart';
import '../../utils/theme/theme.dart';
import 'helper/food_detail/food_price_order_btn.dart';
import 'helper/food_details_view.dart';

class FoodDetail extends ConsumerWidget {
  const FoodDetail({super.key, required this.foodData});

  final FoodDataModel foodData;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final foodWatch = ref.watch(foodController);
    final size = MediaQuery.of(context).size;
    mobileDeviceConfig(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (v){
        ref.read(quantityStateProvider.notifier).update((state) => 1);
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  foodImg(foodData, size, context),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: size.height * 0.40),
                    padding: EdgeInsets.only(top: 26.h, left: 16.w, right: 16.w),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.r))),
                    child: FoodDetailView(foodData: foodData),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 25.h,
              left: 4.w,
              child: Row(
                children: [
                  IconButton.filledTonal(
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(quantityStateProvider.notifier).update((state) => 1);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          padding: EdgeInsets.zero))
      ,
                  SizedBox(width: size.width * 0.57.w),
                 ///------- Admin Buttons-----///
                  !SharedPrefServices.services.getBool(isAdminKey)?const SizedBox(): Row(
                   children: [
                     IconButton.filledTonal(
                         onPressed: () {
                           foodWatch.addExistingDataToFields(foodData, true);
                           Future.delayed(const Duration(milliseconds: 300),(){
                             Navigator.pushNamed(context, AppRoutes.addFood,);
                           });
                         },
                         icon:
                         const Icon(Icons.edit, color: Colors.white, size: 20),
                         style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.kPrimary,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5.r)),
                             padding: EdgeInsets.zero)),
                     IconButton.filledTonal(
                         onPressed: () {
                           showModalBottomSheet(
                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                               context: context,
                               builder: (context) => SizedBox(
                                   width: MediaQuery.of(context).size.width,
                                   child:  DeleteFoodBottomSheet(id: foodData.foodId!,)));
                         },
                         icon: const Icon(Icons.delete, color: Colors.white),
                         style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.kPrimary,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5.r)),
                             padding: EdgeInsets.zero))
                   ],
                 )
                ],
              ),
            ),
           SharedPrefServices.services.getBool(isAdminKey)?const SizedBox(): Positioned(
              bottom: 0.h,
              child: FoodPriceAndOrderButton(
                foodItem: foodData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget foodImg(FoodDataModel item, Size size, BuildContext context) {
    return Hero(
      tag: item.image ?? "",
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy > 10) {
            Navigator.pop(context);
          }
        },
        child: Container(
          width: size.width,
          height: size.height * 0.5,
          color: Colors.lightBlue,
          child: CachedNetworkImage(
            imageUrl: item.image!,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const FlutterLogo(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
