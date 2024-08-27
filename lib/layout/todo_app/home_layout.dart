import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/shared/cubit/cubit.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  var textFieldControl = TextEditingController();
  var timeFieldControl = TextEditingController();
  var dateFieldControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, state) => {
          if (state is AppInsertDatabaseState) {Navigator.pop(context)}
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: const Text('Todo app'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: textFieldControl.text,
                      date: dateFieldControl.text,
                      time: timeFieldControl.text,
                    );
                  }
                } else {
                  cubit.scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                            padding: const EdgeInsets.all(20.0),
                            color: Colors.grey[100],
                            child: Form(
                              key: cubit.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: textFieldControl,
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: timeFieldControl,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeFieldControl.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: dateFieldControl,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-10-03'),
                                      ).then((value) {
                                        dateFieldControl.text =
                                            DateFormat.yMMMd().format(value!);
                                        return null;
                                      });
                                    },
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Date Time',
                                    prefix: Icons.calendar_today,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheet(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived'),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
