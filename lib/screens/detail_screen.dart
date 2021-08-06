import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.post}) : super(key: key);

  final post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: Center(
          child: Column(
            children: [
              Text(DateFormat('E, MMM d, yyyy').format(post['date'].toDate()),
                  style: Theme.of(context).textTheme.headline4),
              Spacer(),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post['imageURL']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Spacer(),
              Text('${post['quantity'].toString()} items',
                  style: Theme.of(context).textTheme.headline4),
              Spacer(),
              Text(
                  'Location: (${post['latitude'].toString()}, ${post['longitude'].toString()})'),
            ],
          ),
        ),
      ),
    );
  }
}
