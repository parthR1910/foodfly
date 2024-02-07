import 'package:food_fly/framework/data/providers/quantity_state_provider.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class FoodQuantityPicker extends ConsumerWidget {
  final FoodDataModel foodDataModel;

  const FoodQuantityPicker({super.key, required this.foodDataModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Quantity :', style: AppTextStyle.w5.copyWith(fontSize: 16.sp)),
          SizedBox(
            height: 5.h,
          ),
          Row(children: [
            iconButton(
                iconData: Icons.remove,
                onTap: () {
                  if (!(ref.watch(quantityStateProvider) <= 1)) {
                    ref.read(quantityStateProvider.notifier).update((state) {
                      int val = state;
                      val--;
                      return val;
                    });
                  }
                }),
            SizedBox(width: 10.w),
            Text('${ref.watch(quantityStateProvider)}',
                style: AppTextStyle.w5.copyWith(fontSize: 20.sp)),
            SizedBox(width: 10.w),
            iconButton(
                iconData: Icons.add,
                onTap: () {
                  ref.read(quantityStateProvider.notifier).update((state) {
                    int val = state;
                    val++;
                    return val;
                  });
                })
          ])
        ]),
        Text(
            " ₹ ${ref.watch(quantityStateProvider) * (foodDataModel.price! - foodDataModel.offPrice!)}",
            style: AppTextStyle.w5.copyWith(fontSize: 25.sp))
      ],
    );
  }

  iconButton({
    required IconData iconData,
    required void Function() onTap,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: 30.h,
            width: 30.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.kWhite,
                border: Border.all(color: AppColors.kBlack)),
            child: Center(child: Icon(iconData, size: 25.r))));
  }
}
