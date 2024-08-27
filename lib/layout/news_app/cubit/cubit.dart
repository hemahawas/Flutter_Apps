import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/news_app/cubit/states.dart';
import 'package:my_project/modules/news_app/business/business_screen.dart';
import 'package:my_project/modules/news_app/science/science_screen.dart';
import 'package:my_project/modules/news_app/sports/sports_screen.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';
import 'package:my_project/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1)
      getSportsData();
    else if (index == 2) getScienceData();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '019e5bbf6fc54c85b484edb790e7ac78'
    }).then((value) {
      business = value.data['articles'];
      //print(business);
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '019e5bbf6fc54c85b484edb790e7ac78'
    }).then((value) {
      sports = value.data['articles'];
      //print(business);
      emit(NewsSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '019e5bbf6fc54c85b484edb790e7ac78'
    }).then((value) {
      science = value.data['articles'];
      //print(business);
      emit(NewsScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearchData(searched) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(path: 'v2/everything', query: {
      'q': '$searched',
      'apiKey': '019e5bbf6fc54c85b484edb790e7ac78'
    }).then((value) {
      search = value.data['articles'];
      //print(business);
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  changeColorMode({bool? isDarkApp}) {
    if (isDarkApp != null) {
      isDark = isDarkApp;
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeColorModeStates());
        print(value.toString());
      });
    }
  }
}
