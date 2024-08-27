import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/cubit/cubit.dart';
import 'package:my_project/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return screenBuilder(
          tasks: tasks,
            status: TaskStatus.doneE,
        );
      },
    );
  }
}
