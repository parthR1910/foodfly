import 'theme/theme.dart';

mobileDeviceConfig(BuildContext context) {
  return ScreenUtil.init(context,
      designSize: const Size(375, 812), minTextAdapt: true);
}

webDeviceConfig(BuildContext context) {
  return ScreenUtil.init(context,
      designSize: const Size(1920, 1080), minTextAdapt: true);
}
