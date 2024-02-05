import 'package:food_fly/framework/data/dummy_data.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'category_item.dart';

class RecommendedFood extends ConsumerWidget {
  final List<FoodDataModel> foodList;
  const RecommendedFood({super.key,required this.foodList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = foodList.where((element) => element.categoryId! == "Recommended").toList();

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        // final item = availableFoods[index];
        final item = data[index];

        return CategoryFoodItem(foodDate: item);
      },
    );
  }
}
