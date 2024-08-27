import 'package:flutter/material.dart';
import 'package:my_project/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:my_project/shared/components/components.dart';
import 'package:my_project/shared/network/local/cache/cache_helper.dart';
import 'package:my_project/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/OB1.png',
      title: 'Purchase Online',
      body: 'Discover the latest trends and exclusive deals right at your fingertips!',
    ),
    BoardingModel(
      image: 'assets/images/OB2.png',
      title: 'Pay',
      body: 'Shop smarter, save more! Enjoy a seamless shopping experience with us.',
    ),
    BoardingModel(
      image: 'assets/images/OB3.png',
      title: 'Be Happy',
      body: 'Your favorite brands, all in one place. Start exploring now!',
    ),
  ];

  var boardControl = PageController();

  bool isLast = false;

  void onBoardingSubmit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              onBoardingSubmit();
            },
            style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
            child: const Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardControl,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildOnBoard(boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControl,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor[100],
                  onPressed: () {
                    if (isLast) {
                      onBoardingSubmit();
                    } else {
                      boardControl.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoard(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            height: 300.0,
            child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.grey
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      );
}
