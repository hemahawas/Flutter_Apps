import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCoverImagePickedSuccessState) {
          SocialCubit.get(context).uploadCoverImage();
        }
        if (state is SocialProfileImagePickedSuccessState) {
          SocialCubit.get(context).uploadProfileImage();
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            title: 'Edit Profile',
            context: context,
            actions: [
              defaultTextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  text: 'update')
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                Container(
                  height: 200.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 160.0,
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                image: coverImage == null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          '${userModel.cover}',
                                        ))
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(coverImage),
                                      ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 17.0,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: 17.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 53.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: profileImage != null
                                ? CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: FileImage(profileImage),
                                  )
                                : CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage:
                                        NetworkImage('${userModel.image}'),
                                  ),
                          ),
                          CircleAvatar(
                            radius: 15.0,
                            child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: Icon(
                                IconBroken.Camera,
                                size: 15.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (state is SocialUploadCoverImageLoadingState)
                  Column(
                    children: const [
                      Text('Uploading cover image ...'),
                      SizedBox(
                        height: 10.0,
                      ),
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                if (state is SocialUploadProfileImageLoadingState)
                  Column(
                    children: const [
                      Text('Uploading profile image ...'),
                      SizedBox(
                        height: 10.0,
                      ),
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      }
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
