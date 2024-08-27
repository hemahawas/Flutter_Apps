import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/models/social_app/post_model.dart';
import 'package:my_project/shared/styles/colors.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  List<TextEditingController> commentTextController = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image(
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1483389127117-b6a2102724ae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    commentTextController.add(TextEditingController());
                    return buildPostItem(
                        SocialCubit.get(context).posts[index], context, index);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel? model, context, modelIndex) => Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model!.image!),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 15.0),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 15.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        model.dateTime!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.text!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.0, height: 1.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Container(
                          height: 30.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Container(
                  height: 120.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        model.postImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes.isNotEmpty ? SocialCubit.get(context).likes[modelIndex].toInt() : '0'}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (SocialCubit.get(context).comments[
                                SocialCubit.get(context).postsId[modelIndex]] !=
                            null) {
                          showBottomSheet(
                            context: context,
                            builder: (context) => ListView.separated(
                              itemBuilder: (context, index) => buildCommentItem(
                                  context,
                                  SocialCubit.get(context).comments[
                                      SocialCubit.get(context)
                                          .postsId[modelIndex]]![index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10.0,
                              ),
                              itemCount: SocialCubit.get(context)
                                  .comments[SocialCubit.get(context)
                                      .postsId[modelIndex]]!
                                  .length,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18,
                              color: Colors.amberAccent,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              SocialCubit.get(context).comments[
                                          SocialCubit.get(context)
                                              .postsId[modelIndex]] ==
                                      null
                                  ? '0'
                                  : SocialCubit.get(context)
                                      .comments[SocialCubit.get(context)
                                          .postsId[modelIndex]]!
                                      .length
                                      .toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image!,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: commentTextController[modelIndex],
                              decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).commentPost(
                                        SocialCubit.get(context)
                                            .postsId[modelIndex],
                                        commentTextController[modelIndex].text);
                                  },
                                  icon: Icon(IconBroken.Send),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postsId[modelIndex]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 5.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            IconBroken.Heart,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildCommentItem(context, String comment) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).userModel!.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(comment),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
