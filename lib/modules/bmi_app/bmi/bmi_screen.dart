import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_project/modules/bmi_app/bmi_result/bmi_result_screen.dart';

class BmiScreen extends StatefulWidget {
  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height = 120;
  double age = 20;
  double weight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male,
                                size: 100,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'MALE',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            color: isMale ? Colors.blue : Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(
                            Icons.female,
                            size: 100,
                          ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'MALE',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            color: !isMale ? Colors.blue : Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    color: Colors.greenAccent,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${height.round()}',
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CM',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Slider(
                        value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(
              //     10.0,
              //   ),
              //   color: Colors.greenAccent,
              // ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'weight',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${weight.round()}',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  heroTag: 'weight',
                                  mini: true,
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  heroTag: 'weight',
                                  mini: true,
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'AGE',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${age.round()}',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                  heroTag: 'age-',
                                  mini: true,
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  heroTag: 'age+',
                                  mini: true,
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.deepPurpleAccent,
            child: MaterialButton(
              onPressed: () {
                var result = weight / pow(height / 100, 2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMIResultScreen(
                      age: age.round(),
                      gender: isMale ? 'male' : 'female',
                      result: result.round(),
                    ),
                  ),
                );
              },
              height: 50.0,
              child: Text(
                'CALCUATE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
