import 'package:flutter/material.dart';

import 'package:wasteagram/models/food_waste_post.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.post}) : super(key: key);

  final FoodWastePost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
        leading: Semantics(
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          button: true,
          enabled: true,
          label: 'Tap to return to list screen',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: Center(
          child: Column(
            children: [
              Semantics(
                child: Text(post.abbreviatedDate,
                    style: Theme.of(context).textTheme.headline4),
                textField: true,
                readOnly: true,
                label: 'Submission date',
              ),
              Spacer(),
              Semantics(
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                image: true,
                label: 'Image of wasted food items',
              ),
              Spacer(),
              Semantics(
                child: Text('${post.quantity.toString()} items',
                    style: Theme.of(context).textTheme.headline4),
                textField: true,
                readOnly: true,
                label: 'Number of wasted food items',
              ),
              Spacer(),
              Semantics(
                child: Text(
                    'Location: (${post.formattedLatitude}, ${post.formattedLongitude})'),
                textField: true,
                readOnly: true,
                label: 'Submission location',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
