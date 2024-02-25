import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/features/splash/controller/splash_controller.dart';

import '../../common/config/theme/theme_export.dart';


class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    ref.read(splashControllerProvider).init(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.primaryColor,
      body: _body(),
    );
  }

  Center _body() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Consumer(builder: (context, ref, child) {
              return Text('Food Fly \nDelivery Partner',
textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white, fontSize: 32.sp))
                  .animate()
                  .slideY(
                duration: 1500.ms,
              )
                  .move(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
                  .fade(duration: 1500.ms);
            })
          ],
        ));
  }
}