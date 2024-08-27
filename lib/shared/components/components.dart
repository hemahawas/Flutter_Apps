import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/models/shop_app/home_model.dart';
import 'package:my_project/modules/news_app/web_view/web_view_screen.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/cubit/cubit.dart';
import 'package:my_project/shared/styles/colors.dart';
import 'package:my_project/shared/styles/icon_broken.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backGround = Colors.blue,
  required String text,
  required VoidCallback function,
}) =>
    Container(
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(20.0)
      ),
      height: 40.0,
      width: width,
      child: MaterialButton(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        onPressed: function,
      ),
    );

Widget defaultTextButton({
  required Function onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Text(
        '${text.toUpperCase()}',
        style: TextStyle(
          fontFamily: 'Fabrica',
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange,
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      cursorColor: Colors.deepOrange,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        } else {
          return;
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          return;
        }
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        } else {
          return;
        }
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(color: Colors.deepOrange),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  if (suffixPressed != null) {
                    suffixPressed();
                  } else {
                    return;
                  }
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.deepOrange),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.deepOrange),
        ),
      ),
    );

enum TaskStatus {newE, doneE, archivedE}

Widget buildTaskItem(Map model,TaskStatus status, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                status == TaskStatus.newE ?
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id'])
                :
                AppCubit.get(context)
                    .updateData(status: 'new', id: model['id'])
                ;
              },
              icon: status == TaskStatus.doneE ? const Icon(
                Icons.check_box,
                color: Colors.blueAccent,
              )
                  :
              const Icon(
                Icons.check_box_outline_blank,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            IconButton(
              onPressed: () {
                status == TaskStatus.newE ?
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id'])
                    :
                AppCubit.get(context)
                    .updateData(status: 'new', id: model['id'])
                ;
              },
              icon: status == TaskStatus.archivedE ? const Icon(
                Icons.unarchive,
                color: Colors.blueAccent,
              )
                  :
              const Icon(
                Icons.archive,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );



Widget screenBuilder({required List<Map> tasks, required TaskStatus status}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], status, context),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10.0,
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 30.0,
              color: Colors.blueGrey,
            ),
            Text(
              'No tasks yet',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );

// News App

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: article['urlToImage'] != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(article['urlToImage']),
                  ),
                )
              : BoxDecoration(),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                article['publishedAt'],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildArticleScreen(list) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.orangeAccent,
          ),
        ),
        itemCount: list.length,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, screen) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ));

void navigateAndFinish(context, screen) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      // Remove the previous screens
      (Route<dynamic> route) => false,
    );

void showToast({
  required String message,
  required state,
}) =>
    Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: stateColor(state),
            textColor: Colors.white,
            fontSize: 16.0)
        .catchError((error) {
      print(error.toString());
    });

enum ToastColor { success, error, warning }



Color stateColor(ToastColor state) {
  Color color;
  switch (state) {
    case ToastColor.success:
      color = Colors.green;
      break;
    case ToastColor.error:
      color = Colors.red;
      break;
    case ToastColor.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        icon: Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
      ),
      actions: actions,
    );




Widget waitingImage(height, width) => Container(
  decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
),
);
