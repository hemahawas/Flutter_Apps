import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_project/layout/shop_app/cubit/cubit.dart';
import 'package:my_project/layout/shop_app/cubit/states.dart';
import 'package:my_project/layout/shop_app/shop_layout.dart';
import 'package:my_project/models/shop_app/home_model.dart';
import 'package:my_project/modules/shop_app/products/products_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/styles/colors.dart';

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(condition: cubit.selectedItems.isNotEmpty,
            builder: (context) =>
                Scaffold(
                  appBar: AppBar(
                    title: Text("Shopping"),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: (){
                        navigateTo(context, ShopLayout());
                      },
                    ),
                  ),
                  body: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: double.infinity,

                        child: Text(
                          'Total: ${cubit.getTotalPrice()}',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      Expanded(
                        child: ListView.separated(
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                buildShoppingProduct(
                                    cubit.selectedItems.keys.elementAt(index), cubit.selectedItems.values.elementAt(index), context),
                            separatorBuilder: (context, index) =>
                                Container(
                                  height: 1.0,
                                  width: 5.0,
                                  color: Colors.grey[300],
                                ),
                            itemCount: cubit.selectedItems.length
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      MaterialButton(
                          onPressed: (){},
                        child: Container(

                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          alignment: Alignment.center,
                          height: 50.0,
                          width: double.infinity,

                          child: Text(
                            'CHECKOUT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),),
                        )
                      ),
                      SizedBox(height: 10.0,),
                    ],
                  ),
                ),
            fallback: (context) =>
                Scaffold(
                  appBar: AppBar(
                    title: const Text('Shopping'),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        navigateTo(context, ShopLayout());
                      },
                    ),
                  ),
                  body: Center(child: Container(
                    child: Text('No Items Yet'),
                  )),
                ),

          );
        },
        listener: (context, state) {});
  }


  buildShoppingProduct(ProductModel model, int length, context) =>
      Dismissible(
        key: Key(model.id.toString()),
        onDismissed: (direction){
          ShopCubit.get(context).removeItem(model);
        },
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
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
                            "${model.price}",
                            style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${model.oldPrice}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            color: Colors.deepOrange,
                              onPressed: (){
                                ShopCubit.get(context).decrementItem(model);
                              },
                              icon: Icon( size: 35.0,
                                  Icons.remove_circle_outline)),
                          Container(
                            alignment: Alignment.center,
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              "$length",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                              color: Colors.deepOrange,
                              onPressed: (){
                                ShopCubit.get(context).addItem(model);
                              },
                              icon: Icon( size: 35.0,
                                  Icons.add_circle_outline)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}