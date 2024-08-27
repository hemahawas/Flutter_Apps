import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:my_project/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:my_project/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:my_project/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todoo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error when Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      db = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((List<Map> value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getFromDatabase(db);
      }).catchError((error) {
        print('error ${error.toString()}');
      });
    });
  }

  void updateData({required String status, required int id}) {
    db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then(
        (value) {
      getFromDatabase(db);
      emit(AppUpdateDatabaseLoadingState());
    });
  }

  void deleteData({required int id}) {
    db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(db);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
