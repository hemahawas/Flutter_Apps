import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_project/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    'Login',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(), //
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: defaultButton(
                      text: 'login',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(email.text);
                          print(password.text);
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blue,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have account ?'),
                      TextButton(onPressed: () {}, child: Text('Register')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
