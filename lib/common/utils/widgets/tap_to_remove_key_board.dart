import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';

class TapToRemoveKeyBoardWidget extends StatelessWidget {
  const TapToRemoveKeyBoardWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Material(
        child: child,
      ),
    );
  }
}
