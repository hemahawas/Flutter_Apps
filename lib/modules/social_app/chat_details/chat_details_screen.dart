import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/models/social_app/message_model.dart';
import 'package:my_project/models/social_app/social_user_model.dart';
import 'package:my_project/shared/styles/colors.dart';
import 'package:my_project/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;

  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    userModel!.image!,
                  ),
                  radius: 25.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(userModel!.name!),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (SocialCubit.get(context).userModel!.uId ==
                            message.senderId) {
                          return buildMyMessage(message);
                        }
                        return buildMessage(message);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: EdgeInsetsDirectional.only(start: 8.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message...',
                                suffixIcon: Container(
                                  color: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: userModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                    },
                                    icon: Icon(
                                      IconBroken.Send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              controller: messageController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(model.text!),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(8.0),
              topStart: Radius.circular(8.0),
              topEnd: Radius.circular(8.0),
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(model.text!),
          decoration: BoxDecoration(
            color: defaultColor[200],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(8.0),
              topStart: Radius.circular(8.0),
              topEnd: Radius.circular(8.0),
            ),
          ),
        ),
      );
}
