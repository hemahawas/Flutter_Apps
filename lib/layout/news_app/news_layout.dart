import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/news_app/cubit/cubit.dart';
import 'package:my_project/layout/news_app/cubit/states.dart';
import 'package:my_project/modules/news_app/search/search_screen.dart';
import 'package:my_project/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  iconSize: 30.0,
                ),
                IconButton(
                  icon: const Icon(Icons.brightness_4_rounded),
                  onPressed: () {
                    cubit.changeColorMode();
                  },
                  iconSize: 30.0,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
