import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/shared/components/HomePageShimmer.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameControl = TextEditingController();
  var emailControl = TextEditingController();
  var phoneControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessUpdateUserState)
          showToast(message: "Updated Successfully", state: ToastColor.success);
      },
      builder: (context, state) {
        nameControl.text = ShopCubit.get(context).userModel?.data?.name??'';
        emailControl.text = ShopCubit.get(context).userModel?.data?.email??'';
        phoneControl.text = ShopCubit.get(context).userModel?.data?.phone??'';
        var width = MediaQuery.sizeOf(context).width;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                defaultShimmer(height: 50.0,width: width),
                SizedBox(height: 30.0,),
                defaultShimmer(height: 50.0,width: width),
                SizedBox(height: 30.0,),
                defaultShimmer(height: 50.0,width: width),
                SizedBox(height: 30.0,),
              ],
            ),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameControl,
                    type: TextInputType.name,
                    validate: () {},
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: emailControl,
                    type: TextInputType.emailAddress,
                    validate: () {},
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneControl,
                    type: TextInputType.number,
                    validate: () {},
                    label: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'SIGN OUT',
                    function: () {
                      signOut(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Update',
                    function: () {
                      ShopCubit.get(context).putUserData(
                        name: nameControl.text,
                        email: emailControl.text,
                        phone: phoneControl.text,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
