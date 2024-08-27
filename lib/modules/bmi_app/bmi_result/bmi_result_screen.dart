import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  int result;
  String gender;
  int age;

  BMIResultScreen({
    required this.age,
    required this.result,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Result',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender: $gender',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              'Result: $result',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              'Age: $age',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
