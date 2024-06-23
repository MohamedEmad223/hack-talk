import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_talk/core/helpers/extension.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/text_widgets.dart';
import 'package:hack_talk/features/auth/presentation/widgets/app_bar.dart';
import 'package:hack_talk/features/features/features_screen.dart';
import 'package:hack_talk/features/home/presentation/screen/home/alertWidget.dart';
import 'package:hack_talk/features/home/presentation/screen/home/Computer_vision_screen.dart';
import 'package:hack_talk/features/home/presentation/widgets/home_button_widget.dart';
import 'package:hack_talk/features/setting/setting/view/screens/setting_screen.dart';

import 'drawer_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: Drawer(
        backgroundColor: AppColors.drawerColor,
        width: MediaQuery.of(context).size.width * 0.6,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset('assets/images/Frame 385.png'),
              ),
              DrawerWidget(
                text: 'Features',
                icon: Icons.star_border,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const FeaturesScreen(),
                  );
                },
              ),
              DrawerWidget(
                text: 'Setting',
                icon: Icons.settings,
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingScreen()));
                },
              ),
               DrawerWidget(text: 'LogOut', icon: Icons.logout,onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const AlertDialogWidget()));
              },)
              
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('home'.getSvgAsset),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Row(
                  children: [
                    SvgPicture.asset('ellipse'.getSvgAsset),
                    const SizedBox(width: 8),
                    const TextWidget('Choose the option that suits you best'),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: HomeButtonWidget(
                      color: AppColors.homeButtonColor,
                      text: 'Computer Vision',
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ComputerVisionScreen(),
                            ),
                          );
                        });
                      },
                      textColor: AppColors.mainColor,
                      image: '',
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: HomeButtonWidget(
                      color: AppColors.homeButtonColor,
                      text: 'Speech',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComputerVisionScreen(),
                          ),
                        );
                      },
                      textColor: AppColors.mainColor,
                      image: '',
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: HomeButtonWidget(
                      color: AppColors.homeButtonColor,
                      text: 'Virtual reality',
                      onPressed: () {
                       
                      },
                      textColor: AppColors.mainColor,
                      image: '',
                    ),
                  ),
                  
                ],
              ),
          
              const SizedBox(
                height: 44,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
