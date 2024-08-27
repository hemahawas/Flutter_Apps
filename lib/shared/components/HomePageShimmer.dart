import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.sizeOf(context).width;
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Shimmer.fromColors(
          child: Column(
            children: [
              defaultShimmer(height: 250.0,),
              SizedBox(height: 30.0,),
              Center(child: defaultShimmer(height: 20.0, width: 150.0)),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  defaultShimmer(height: 70.0, width: width/5),
                  SizedBox(width: 20.0,),
                  defaultShimmer(height: 70.0, width: width/5),
                  SizedBox(width: 20.0,),
                  defaultShimmer(height: 70.0, width: width/5),
                  SizedBox(width: 20.0,),
                  defaultShimmer(height: 70.0, width: width/5)
                ],
              ),
              SizedBox(height: 30.0,),
              Center(child: defaultShimmer(height: 20.0, width: 150.0)),
              SizedBox(height: 30.0,),
              GridView.count(crossAxisCount: 2,
                shrinkWrap: true,
                padding: const EdgeInsets.all(5.0),
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1 / 1.35,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(4, (index) {
                  return defaultShimmer(height: 60.0, width: 20.0);
                }),
              ),
            ],
          ),
          baseColor: Colors.grey.shade300  ,
          highlightColor: Colors.grey.shade100,
        ),
      ),
    );
  }

}

Widget defaultShimmer({height,width}) => Container(
    height:height??null,
    width: width??null,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15.0)),
);