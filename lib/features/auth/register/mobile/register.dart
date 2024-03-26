import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_loading.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/register_controller.dart';

import 'helper/register_view.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CommonLoading(
      show: ref.watch(registerController).loading,
      child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: _appBar(ref, context),
        body:  RegisterView(),
      ),
    ),);
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) => AppBar(
    backgroundColor: context.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back,color: Colors.white,),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up',
                style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white, fontSize: 22.sp)),
            Text('Register And Earn',
                style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey.shade200, fontSize: 14.sp))
          ],
        ),
      );
}
