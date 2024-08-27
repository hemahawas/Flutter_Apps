import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/social_layout.dart';
import 'package:my_project/modules/social_app/social_register/cubit/cubit.dart';
import 'package:my_project/modules/social_app/social_register/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameControl = TextEditingController();
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();
  var phoneControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
      listener: (context, state) => {
        if (state is SocialRegisterSuccessState)
          {navigateAndFinish(context, SocialLayout())}
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultFormField(
                  controller: nameControl,
                  type: TextInputType.name,
                  validate: () {},
                  label: 'User Name',
                  prefix: Icons.drive_file_rename_outline,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  controller: emailControl,
                  type: TextInputType.emailAddress,
                  validate: () {},
                  label: 'Email Address',
                  prefix: Icons.email,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  controller: passwordControl,
                  type: TextInputType.visiblePassword,
                  validate: () {},
                  label: 'Password',
                  prefix: Icons.lock,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  controller: phoneControl,
                  type: TextInputType.number,
                  validate: () {},
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                    text: 'register',
                    function: () {
                      SocialRegisterCubit.get(context).userRegister(
                        name: nameControl.text,
                        email: emailControl.text,
                        password: passwordControl.text,
                        phone: phoneControl.text,
                      );
                    }),
                if (state is SocialRegisterLoadingState)
                  LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
