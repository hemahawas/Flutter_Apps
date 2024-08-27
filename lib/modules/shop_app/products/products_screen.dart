import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/models/shop_app/categories_model.dart';
import 'package:my_project/models/shop_app/home_model.dart';
import 'package:my_project/shared/components/HomePageShimmer.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopAddItemSuccessState)
          showToast(message: "Item added successfully", state: ToastColor.success);

        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model!.status) {
            showToast(message: state.model!.message!, state: ToastColor.error);
          }
        }
      },
      builder: (context, State) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModelUploaded &&
              cubit.categoriesUploaded,
          builder: (context) =>
              productBuilder(ShopCubit
                  .get(context)
                  .homeModel,
                  ShopCubit
                      .get(context)
                      .categoriesModel, context),
          fallback: (context) =>
           Container(child: HomePageShimmer()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model, CategoriesModel? catModel, context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0)
            ),
            child: CarouselSlider(
              items: model?.data.banners
                  .map(
                    (e) => ShopCubit.get(context).isBlur[e.id]! ?
                    Container(
                        clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: NetworkImage(e.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white.withOpacity(0.0)),

                        ),
                      ),
                      width: double.infinity,
                    )
                        :
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                      child: Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                initialPage: 0,
                height: 250.0,
                enableInfiniteScroll: true,
                reverse: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration:const  Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          const Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Container(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  buildCategoriesItem(catModel!.data.data[index]),
              separatorBuilder: (context, index) =>
              const SizedBox(
                    width: 10.0,
                  ),
              itemCount: catModel!.data.data.length,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.63,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(model!.data.products.length, (index) {
                return buildGridProduct(model.data.products[index], context);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel? catModel) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(catModel!.image),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              height: 18.0,
              alignment: AlignmentDirectional.bottomCenter,
              width: double.infinity,
              color: Colors.black.withOpacity(
                .7,
              ),
              child: Text(
                catModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  buildGridProduct(ProductModel model, context) => Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
    ),
    child: Column(
      children: [
        MaterialButton(
          onPressed: (){
            showModalBottomSheet(
              context: (context),
               isScrollControlled: true,
              builder: (context) => Container(
                  height: 200.0,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      MaterialButton(onPressed: (){
                        ShopCubit.get(context).addItem(model);
                      }, child:
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        alignment: Alignment.center,
                        height: 50.0,
                        width: double.infinity,

                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),),
                      )
                        ,)
                    ],
                  )
              )
            );
          },
          child: Container(
            child: Image(
              image: NetworkImage(model.image),
              key: ValueKey(model.image),
              height: 200.0,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsetsDirectional.zero,
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: ShopCubit.get(context).favorites[model.id] == true
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
      ],
    ),
  );

}

