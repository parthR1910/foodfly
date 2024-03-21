

import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';

import '../theme/app_colors.dart';
import '../theme/theme.dart';

void commonSnackBar({required BuildContext context, required String eText,Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        eText,
        style: AppTextStyle.w4.copyWith(color: Colors.white, fontSize: 14.sp),
      ),
      backgroundColor:backgroundColor?? AppColors.kPrimary,
    ),
  );
}

void commonToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}