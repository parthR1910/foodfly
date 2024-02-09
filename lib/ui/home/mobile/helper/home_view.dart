import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/shared_pref_services.dart';
import 'package:food_fly/ui/home/mobile/helper/recommanded_food_slider/food_item_slider.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/extension/widget_extension.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/framework/controller/food_category/category_tab_controller.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'food_category/category/new_taste_food.dart';
import 'food_category/category/popular_food.dart';
import 'food_category/category/recommanded_food.dart';
import 'food_category/food_category.dart';

class HomeView extends ConsumerWidget {
  final List<FoodDataModel> foodList;
  const HomeView({super.key,required this.foodList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SharedPrefServices.services.getBool(isAdminKey)?
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Add New Food",style: AppTextStyle.w6.copyWith(fontSize: 16.sp)),
              CommonButton(onTap: (){
                Navigator.pushNamed(context, AppRoutes.addFood);
              },padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w), child: Text("Add Food",style: AppTextStyle.w6.copyWith(fontSize: 12.sp),)),
            ],
          ).paddingOnly(left: 16.w,right: 14.w,bottom: 5.h)
          :
          const SizedBox(),
           FoodItemSlider(foodList: foodList,),
          const FoodCategory(),
          Expanded(
            child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: ref.watch(categoryTabController).pageController,
                          children:  [NewTasteFood(foodList: foodList,), PopularFood(foodList: foodList,), RecommendedFood(foodList: foodList,)],
                        ),
          )

          // FoodCatPageView(),
        ],
      ),
    );
  }
}
