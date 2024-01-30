import 'package:food_fly/ui/home/mobile/helper/recommanded_food_slider/food_item_slider.dart';
import 'package:food_fly/ui/utils/extension/widget_extension.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/framework/controler/food_category/category_tab_controller.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'food_category/category/new_taste_food.dart';
import 'food_category/category/popular_food.dart';
import 'food_category/category/recommanded_food.dart';
import 'food_category/food_category.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Add New Food",style: AppTextStyle.w6.copyWith(fontSize: 16.sp)),
              CommonButton(onTap: (){},padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w), child: Text("Add Food",style: AppTextStyle.w6.copyWith(fontSize: 12.sp),)),
            ],
          ).paddingOnly(left: 16.w,right: 14.w,bottom: 5.h),
          const FoodItemSlider(),
          const FoodCategory(),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: ref.watch(foodCategoryController).pageController,
            children: const [NewTasteFood(), PopularFood(), RecommendedFood()],
          ))

          // FoodCatPageView(),
        ],
      ),
    );
  }
}
