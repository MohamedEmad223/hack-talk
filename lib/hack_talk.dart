import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hack_talk/core/routes/app_routes.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';

class HackTalk extends StatelessWidget {
  const HackTalk({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //* The size of the screen of figma design.
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        initialRoute: Routes.home,
        onGenerateRoute: AppRoutes().onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            iconTheme: IconThemeData(
              color: AppColors.mainColor,
              size: 28.r,
            ),
          ),
          primaryColorLight: AppColors.mainColor,
          scaffoldBackgroundColor: const Color(0xffFFFFFF),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}

