import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var dateTimeController = TextEditingController();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                text: 'Post',
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  Column(
                    children: const [
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model!.image!),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      model.name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15.0),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what\'s in your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (state is SocialPostImagePickedSuccessState)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160.0,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 17.0,
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 17.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
