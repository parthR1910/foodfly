
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'food_category_tab.dart';

class FoodCategory extends ConsumerWidget {
  const FoodCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(length: 3, child: CategoryTabBar());
  }
}
