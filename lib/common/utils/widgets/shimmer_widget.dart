import '../../../../common/config/theme/theme_export.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.height, required this.width,  this.borderRadius=5,  this.isCircle=false});
  final double height;
  final double width;
  final double borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: isCircle?BoxShape.circle:BoxShape.rectangle,
              color: Colors.grey, borderRadius:isCircle?null: BorderRadius.circular(borderRadius)),
        ));
  }
}
