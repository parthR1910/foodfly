import '../../../../../../framework/model/food_data_model/food_data_model.dart';
import '../../../../../utils/theme/theme.dart';
import 'category_item.dart';

class NewTasteFood extends ConsumerWidget {
  final List<FoodDataModel> foodList;

  const NewTasteFood({super.key,required this.foodList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = foodList.where((element) => element.categoryId! == "New Taste").toList();
    return SingleChildScrollView(
      child: Column(
        children: List.generate(data.length, (index) {
          final item = data[index];
          return CategoryFoodItem(foodData: item,);
        }),
      ),
    );
    //   ListView.builder(
    //   itemCount: data.length,
    //   itemBuilder: (context, index) {
    //     // final item = availableFoods[index];
    //     final item = data[index];
    //     return CategoryFoodItem(foodDate: item,);
    //   },
    // );
  }
}
