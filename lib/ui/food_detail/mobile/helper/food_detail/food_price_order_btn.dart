import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/model/food_item.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../../../utils/theme/theme.dart';
import '../../../../utils/widgets/common_button.dart';

class FoodPriceAndOrderButton extends ConsumerWidget {
  const FoodPriceAndOrderButton({super.key, required this.foodItem});
  final FoodDataModel foodItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(color: Colors.grey.shade100, spreadRadius: 5, blurRadius: 10)
        // ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appString.keyTotalPrice,
                style: AppTextStyle.w4.copyWith(fontSize: 13.sp),
              ),
              Text(
                'IDR ${foodItem.price}.00',
                style: AppTextStyle.w4.copyWith(fontSize: 18.sp),
              )
            ],
          ),
          orderNowButton
        ],
      ),
    );
  }

  Widget get orderNowButton => Consumer(builder: (context, ref, child) {
        final appString = ref.watch(appStringController);
        return CommonButton(
            backgroundColor: const Color(0xFF241719),
            padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h),
            child: Text(appString.keyOrderNow),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.payment);
            });
      });
}
