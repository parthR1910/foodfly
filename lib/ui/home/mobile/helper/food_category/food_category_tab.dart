import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/framework/controller/food_category/category_tab_controller.dart';

class CategoryTabBar extends ConsumerWidget {
  const CategoryTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appString = ref.watch(appStringController);
    return SizedBox(
      height: 50.h,
      child: TabBar(
          splashFactory: InkSplash.splashFactory,
          onTap: (index) {
            ref.read(foodCategoryController.notifier).navigateToCat(index);
          },
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          splashBorderRadius: BorderRadius.circular(8.r),
          indicatorColor: Colors.black,
          labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
          tabs: [
            Tab(
              child: Text(
                appString.keyNewTaste,
                style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
              ),
            ),
            Tab(
              child: Text(
                appString.keyPopular,
                style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
              ),
            ),
            Tab(
              child: Text(
                appString.keyRecommended,
                style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
              ),
            )
          ]),
    );
  }
}
