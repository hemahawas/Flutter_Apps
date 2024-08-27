import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/R.4c08da903b76ea005a097825569c3cfa?rik=1e5EbgAoUCbGzw&pid=ImgRaw&r=0'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 17.0,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              child: Icon(
                Icons.edit,
                size: 17.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[300]),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('search'),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                    // or ListView.builder()
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStoryItem(),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 5.0,
                        ),
                    itemCount: 15),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                  // or ListView.builder()
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 5.0,
                        height: 5.0,
                      ),
                  itemCount: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/R.4c08da903b76ea005a097825569c3cfa?rik=1e5EbgAoUCbGzw&pid=ImgRaw&r=0'),
              ),
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ahmed Zezo'),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'hello, my name is ahmed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '02:00 PM',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );

  Widget buildStoryItem() => Container(
        width: 50.0,
        child: Column(
          children: [
            Container(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/R.4c08da903b76ea005a097825569c3cfa?rik=1e5EbgAoUCbGzw&pid=ImgRaw&r=0'),
                  ),
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
            Text(
              'Hema Hawas Hema Hawas',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
