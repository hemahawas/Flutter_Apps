import 'package:flutter/material.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/models/shop_app/categories_model.dart';
import 'package:my_project/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: Text(
          'Categories Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(7.0),
        color: Colors.grey[300],
        child: ListView.separated(
          itemBuilder: (context, index) => buildCategoryItem(
              ShopCubit.get(context).categoriesModel!.data.data[index], context),
          separatorBuilder: (context, index) => Container(
            color: Colors.grey[300],
            child: const SizedBox(
              height: 10.0,
            ),
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        ),
      ),
    );
  }

  Widget buildCategoryItem(DataModel model, context) => Container(
    
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.white,),

    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Image(
            image: NetworkImage(model.image),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          model.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15.0,
              ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}
