import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/news_app/cubit/cubit.dart';
import 'package:my_project/layout/news_app/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var textControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var article = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: textControl,
                  onChange: (String value) {
                    NewsCubit.get(context).getSearchData(value);
                  },
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'The value must not be empty';
                    }
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: buildArticleScreen(article)),
            ],
          ),
        );
      },
    );
  }
}
