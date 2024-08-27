import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';

import 'package:my_project/modules/shop_app/search/search_screen.dart';
import 'package:my_project/modules/shop_app/shopping/shopping_screen.dart';
import 'package:my_project/shared/components/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: const Icon(null),
            title: const Text(
              'salla',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, ShoppingScreen());
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.shopScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home,
                  )),
              BottomNavigationBarItem(
                  label: 'Categories',
                  icon: Icon(
                    Icons.apps,
                  )),
              BottomNavigationBarItem(
                  label: 'Favorites',
                  icon: Icon(
                    Icons.favorite,
                  )),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(
                    Icons.settings,
                  )),
            ],
          ),
        );
      },
    );
  }
}
