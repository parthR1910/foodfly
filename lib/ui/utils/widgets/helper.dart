import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import '../theme/theme.dart';

showSnackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Text(
      error,
      style: AppTextStyle.w6.copyWith(fontSize: 12.sp, color: AppColors.kWhite),
    ),
    backgroundColor: AppColors.kPrimary,
    duration: 3.seconds,
  ));
}
