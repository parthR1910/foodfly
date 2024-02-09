import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:food_fly/firebase_options.dart';
import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/framework/service/hive_service/hive_adapter.dart';
import 'package:food_fly/ui/edit_profile/edit_profile.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:hive_flutter/adapters.dart';

import 'framework/service/shared_pref_services.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefServices.services.init();
  registerHiveAdapters();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent));
await Hive.initFlutter();
BoxService.boxService.userModelBox =await Hive.openBox<UserModel>(userModelBoxKey);
BoxService.boxService.latLngBox =await Hive.openBox<LatLng>(latLngBoxKey);
  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [
        Locale('en'),],
          path: 'assets/lang',
          useOnlyLangCode: true,
          startLocale: const Locale('en'),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, child) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: EasyLocalization.of(context)!.locale,
      theme: ThemeData().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.kWhite),
      scaffoldBackgroundColor: AppColors.kWhite,
      ),
      initialRoute: AppRoutes.splashRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      //   home: const EditProfile(),
      );
    },
    );
}
