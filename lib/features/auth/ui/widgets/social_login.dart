import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';

import '../../../../common/utils/constants/app_assets.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(child:  Divider(color: Colors.grey.shade200,)),
          SizedBox(width: 5.w,),
          const Text('Or'),
          SizedBox(width: 5.w,),
          Expanded(child: Divider(color: Colors.grey.shade200,)),
        ],),
        SizedBox(height: 20.h),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           // const Text('Not An Account ',style: TextStyle()),
           TextButton(onPressed: (){}, child: const Text('Create New Account')),
         ],
       )
      ],
    );
  }
}
