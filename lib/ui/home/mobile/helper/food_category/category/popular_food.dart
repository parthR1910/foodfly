
import 'package:food_fly/ui/utils/theme/theme.dart';
import '../../../../../../framework/model/food_data_model/food_data_model.dart';
import 'category_item.dart';

class PopularFood extends ConsumerWidget {
  final List<FoodDataModel> foodList;
  const PopularFood({super.key,required this.foodList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = foodList.where((element) => element.categoryId! == "Popular").toList();
    return SingleChildScrollView(
      child: Column(
        children: List.generate(data.length, (index) {
          final item = data[index];
          return CategoryFoodItem(foodData: item,);
        }),
      ),
    );
  }
}
