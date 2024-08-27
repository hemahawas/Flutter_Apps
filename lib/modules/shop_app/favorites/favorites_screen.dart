import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/models/shop_app/favorites_model.dart';
import 'package:my_project/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).favoritesModel != null,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoritesModel!.data.FavData[index],
                  context),
              separatorBuilder: (context, index) => Container(
                height: 1.0,
                width: 5.0,
                color: Colors.grey[300],
              ),
              itemCount:
                  ShopCubit.get(context).favoritesModel!.data.FavData.length,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(FavoritesData model, context) => Container(
        height: 120.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.product.image),
              height: 120.0,
              width: 120.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
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
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          '5000',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsetsDirectional.zero,
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id!);
                          },
                          icon: ShopCubit.get(context)
                                      .favorites[model.product.id] ==
                                  true
                              ? Icon(
                                  Icons.favorite,
                                  size: 30.0,
                                  color: defaultColor,
                                )
                              : const Icon(
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
