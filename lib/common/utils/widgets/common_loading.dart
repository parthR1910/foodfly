import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_colors.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key, required this.child, required this.show});

  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IgnorePointer(
        ignoring: show,
        child: Stack(
          alignment: Alignment.center,
          children: [
            child,
            if (show == true)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: context.primaryColor.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
