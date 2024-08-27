import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/counter_app/cubit/states.dart';

import 'cubit/cubit.dart';

class CounterScreen extends StatelessWidget {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).minus();
                  },
                  child: Text('MINUS'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '${CounterCubit.get(context).counter}',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).plus();
                  },
                  child: Text(
                    'PLUS',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
