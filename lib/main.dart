import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/news_app/cubit/cubit.dart';
import 'package:my_project/layout/news_app/cubit/states.dart';
import 'package:my_project/layout/news_app/news_layout.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/layout/shop_app/shop_layout.dart';
import 'package:my_project/layout/todo_app/home_layout.dart';
import 'package:my_project/modules/basics_app/login/login_screen.dart';
import 'package:my_project/modules/bmi_app/bmi/bmi_screen.dart';

import 'package:flutter/material.dart';
import 'package:my_project/modules/counter_app/counter_screen.dart';
import 'package:my_project/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:my_project/modules/shop_app/register/cubit/cubit.dart';
import 'package:my_project/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:my_project/shared/bloc_observer.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/cubit/cubit.dart';
import 'package:my_project/shared/cubit/states.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';
import 'package:my_project/shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  //Shop App: Passed on Boarding
  bool onboarding = CacheHelper.getData(key: 'onBoarding') == null ? false : true;
  Widget shopStartWidget = onboarding ? LoginScreen() : OnBoardingScreen();

  //Shop App: Already login
  shopStartWidget = CacheHelper.getData(key: 'token') == null ? shopStartWidget : ShopLayout();


  runApp(MyApp(startWidget: shopStartWidget));
}

class MyApp extends StatelessWidget {
  // final botToastBuilder = BotToastInit();
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        // to-do app cubit
        BlocProvider(
          create: (context) => AppCubit(),
        ),

        BlocProvider(
        create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopRegisterCubit(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: themeMode ? lightTheme : darkTheme,
        home:
        startWidget
      ),
    );
  }
}
