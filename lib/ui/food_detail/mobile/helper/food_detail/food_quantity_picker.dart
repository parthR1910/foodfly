
import 'package:food_fly/framework/data/providers/quantity_state_provider.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import 'package:food_fly/ui/utils/theme/theme.dart';

class FoodQuantityPicker extends ConsumerWidget {
  const FoodQuantityPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        iconButton(
          iconData: Icons.remove,
          onTap: () {
            if (!(ref.watch(quantityStateProvider) <= 0)) {
              ref.read(quantityStateProvider.notifier).update((state) {
                int val = state;
                val--;
                return val;
              });
            }
          },
        ),
        SizedBox(width: 10.w),
        Text('${ref.watch(quantityStateProvider)}',
            style: AppTextStyle.w5.copyWith(fontSize: 18.sp)),
        SizedBox(width: 10.w),
        iconButton(
          iconData: Icons.add,
          onTap: () {
            ref.read(quantityStateProvider.notifier).update((state) {
              int val = state;
              val++;
              return val;
            });
          },
        ),
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
          height: 26.h,
          width: 26.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.kWhite,
              border: Border.all(color: AppColors.kBlack)),
          child: Center(
            child: Icon(iconData, size: 20.r),
          )),
    );
  }
}
