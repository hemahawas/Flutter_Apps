import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/cubit/cubit.dart';
import 'package:my_project/layout/social_app/cubit/states.dart';
import 'package:my_project/models/social_app/social_user_model.dart';
import 'package:my_project/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.image!),
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
        ),
      );
}
