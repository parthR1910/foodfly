import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'food_slider_item.dart';

class FoodItemSlider extends StatelessWidget {
  final List<FoodDataModel> foodList;
  const FoodItemSlider({super.key,required this.foodList});

  @override
  Widget build(BuildContext context) {
    /// -------- filter data based on the off price tag ----///
    final data = foodList.where((element) => element.offPrice! >= 75).toList();
    return SizedBox(
        height: 210.h,
        width: double.infinity,
        child: ListView.builder(
          itemCount: data.length,
          padding: EdgeInsets.only(bottom: 10.h, left: 18.w),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            // final foodData = foodList[index];
            final foodData = data[index];
            return  FoodSliderItem( foodData: foodData,);
          }

        ));
  }
}
