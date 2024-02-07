import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../../../utils/theme/theme.dart';

class FoodRatingStar extends StatelessWidget {
  const FoodRatingStar({super.key, required this.ratingStar});
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...buildStars(ratingStar),
        SizedBox(width: 4.w),
        Text(
          ratingStar.toString(),
          style: AppTextStyle.w4.copyWith(fontSize: 10.sp, color: AppColors.kGrey),
        )
      ],
    );
  }
}

List buildStars(int rate) {
  int total = 5;
  int blankStar = total - rate;
  return [
    ...List.generate(rate,
        (index) => Icon(Icons.star, size: 15.spMax, color: AppColors.kPrimary,)),
    ...List.generate(blankStar,
        (index) => Icon(Icons.star, size: 15.spMin, color: AppColors.kGrey)),
  ];
}
