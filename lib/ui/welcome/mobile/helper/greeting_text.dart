import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class GreetingText extends ConsumerWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.h),
        Text(
          appString.keyYeahCompleted,
          style: AppTextStyle.w4.copyWith(fontSize: 20.sp),
        ),
        Text(
          appString.keyGreetingMsg,
          textAlign: TextAlign.center,
          style:
              AppTextStyle.w3.copyWith(fontSize: 14.sp, color: AppColors.kGrey),
        ),
        SizedBox(height: 30.h)
      ],
    );
  }
}
