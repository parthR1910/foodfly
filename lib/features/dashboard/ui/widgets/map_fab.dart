import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/features/map/ui/screens/map.dart';

import '../../../../common/config/theme/theme_export.dart';

class MapFab extends StatelessWidget {
  const MapFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      enableFeedback: true,
      backgroundColor: Colors.black,
      shape: const CircleBorder(),
      onPressed: () async {
        context.push(const MapScreen());
      },
      child:const Icon(Icons.map,color: Colors.white,),
    );
  }
}
