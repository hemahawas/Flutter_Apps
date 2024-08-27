import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/styles/colors.dart';

import '../../../models/shop_app/search_model.dart';

class SearchScreen extends StatelessWidget {
  var searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Screen',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              defaultFormField(
                controller: searchControl,
                type: TextInputType.text,
                validate: () {},
                label: 'Search',
                prefix: Icons.search,
                onSubmit: (String value) {
                  ShopCubit.get(context).searchData(value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              if (state is ShopLoadingSearchState)
                Center(child: LinearProgressIndicator())
              else if (state is ShopSuccessSearchState)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildSearchedProduct(
                        ShopCubit.get(context).searchModel!.data.data[index],
                        context),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: defaultColor,
                      ),
                    ),
                    itemCount:
                        ShopCubit.get(context).searchModel!.data.data.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  buildSearchedProduct(Data model, context) => Container(
        height: 120.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              height: 120.0,
              width: 120.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '2000',
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '5000',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsetsDirectional.zero,
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon:
                              ShopCubit.get(context).favorites[model.id] == true
                                  ? Icon(
                                      Icons.favorite,
                                      size: 30.0,
                                      color: defaultColor,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 30.0,
                                    ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
