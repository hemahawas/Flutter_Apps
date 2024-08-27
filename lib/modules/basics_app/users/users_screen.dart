import 'package:flutter/material.dart';
import 'package:my_project/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'hema', phone: '05541602541'),
    UserModel(id: 2, name: 'ahmed', phone: '05545412541'),
    UserModel(id: 3, name: 'ali', phone: '01154966241'),
    UserModel(id: 4, name: 'hema', phone: '05541602541'),
    UserModel(id: 5, name: 'ahmed', phone: '05545412541'),
    UserModel(id: 6, name: 'ali', phone: '01154966241'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
          itemCount: users.length),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
