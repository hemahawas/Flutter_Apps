import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160.0,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${userModel?.cover}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 53.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage('${userModel?.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel?.name}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Posts',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 15,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Followers',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 15,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '65',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Following',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 15,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Friends',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 15,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(IconBroken.Edit),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
