import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

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
                color: AppColors.kBlack.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kWhite,
                    backgroundColor: AppColors.kPrimary.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
