import 'package:food_fly/ui/home/mobile/helper/recommanded_food_slider/food_item_slider.dart';
import '../../../../framework/controler/food_category/category_tab_controller.dart';
import '../../../utils/theme/theme.dart';
import 'food_category/category/new_taste_food.dart';
import 'food_category/category/popular_food.dart';
import 'food_category/category/recommanded_food.dart';
import 'food_category/food_category.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 36.h, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FoodItemSlider(),
          const FoodCategory(),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: ref.watch(foodCategoryProvider).pageController,
            children: const [NewTasteFood(), PopularFood(), RecommendedFood()],
          ))

          // FoodCatPageView(),
        ],
      ),
    );
  }
}
