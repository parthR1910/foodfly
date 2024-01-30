import 'package:food_fly/framework/data/dummy_data.dart';

import 'package:food_fly/ui/utils/theme/theme.dart';
import 'category_item.dart';

class PopularFood extends ConsumerWidget {
  const PopularFood({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: availableFoods.length,
      itemBuilder: (context, index) {
        final item = availableFoods[index];
        return CategoryFoodItem(foodItem: item);
      },
    );
  }
}
