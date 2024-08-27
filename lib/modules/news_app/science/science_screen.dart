import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/news_app/cubit/cubit.dart';
import 'package:my_project/layout/news_app/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        var list = NewsCubit.get(context).science;
        return buildArticleScreen(list);
      },
    );
  }
}
