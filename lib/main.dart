import 'package:flutter/material.dart';
import 'package:hack_talk/core/helpers/cache_helper.dart';
import 'package:hack_talk/core/helpers/dio_helper.dart';
import 'package:hack_talk/hack_talk.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await CacheHelper().init();
   await DioHelper.init();
  runApp(const HackTalk());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

