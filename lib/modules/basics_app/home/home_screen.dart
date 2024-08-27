import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          'First App',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notification_important_outlined,
            ),
            onPressed: () {
              print('clicked');
            },
          ),
          Icon(
            Icons.search,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      'https://thumbs.dreamstime.com/b/aster-flowers-art-design-26968847.jpg',
                    ),
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 200.0,
                    color: Colors.black,
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
