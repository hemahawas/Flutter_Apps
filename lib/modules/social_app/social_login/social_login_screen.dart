import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/social_app/social_layout.dart';
import 'package:my_project/modules/social_app/social_login/cubit/cubit.dart';
import 'package:my_project/modules/social_app/social_login/cubit/state.dart';
import 'package:my_project/modules/social_app/social_register/social_register_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var textController = TextEditingController();
  var passController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginState>(
      listener: (context, state) => {
        if (state is SocialLoginErrorState)
          {
            showToast(
              state: ToastColor.error,
              message: state.error,
            )
          }
        else if (state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = CacheHelper.getData(key: 'uId');
              navigateAndFinish(context, SocialLayout());
            })
          }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Login to Communicate with friends',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      controller: textController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'The email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email address',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: passController,
                      type: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      label: 'Password',
                      prefix: Icons.lock,
                      suffix: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! SocialLoginLoadingState,
                      builder: (context) => defaultButton(
                        text: 'login',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                              email: textController.text,
                              password: passController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Don\'t have account ?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        defaultTextButton(
                          onPressed: () {
                            navigateTo(context, SocialRegisterScreen());
                          },
                          text: 'register',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
