import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/food_detail/mobile/helper/food_details_view.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'helper/food_detail/food_price_order_btn.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key, required this.foodItem});

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    mobileDeviceConfig(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Stack(
                    children: [
                      fooImg(foodItem, size, context),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(top: size.height * 0.45),
                        padding: EdgeInsets.only(
                            top: 26.h, left: 16.w, right: 16.w),
                        decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.r))),
                        child: FoodDetailView(foodItem: foodItem),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20.h,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      AppAssets.arrowBackSvg,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0.h,
              child: FoodPriceAndOrderButton(
                foodItem: foodItem,
              )),
        ],
      ),
    );
  }

  Widget fooImg(FoodItem item, Size size, BuildContext context) {
    return Hero(
      tag: foodItem.name,
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
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
