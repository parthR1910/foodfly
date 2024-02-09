import '../../../ui/utils/theme/theme.dart';

final categoryTabController =
    ChangeNotifierProvider<CategoryTabController>((ref) {
  return CategoryTabController();
});

class CategoryTabController extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  navigateToCat(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 1000,
      ),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
