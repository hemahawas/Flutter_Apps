import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/modules/social_app/new_post/new_post_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                  size: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 8.0,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.Search,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
