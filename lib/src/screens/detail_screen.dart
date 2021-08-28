import 'package:flutter/material.dart';
import 'package:wasteagram/src/models/food_waste_post.dart';
import 'package:wasteagram/src/widgets/custom_app_bar.dart';

/// The detail screen for a food waste post.
class DetailScreen extends StatelessWidget {
  /// The title of the app bar.
  final String title;

  /// The food waste post to display.
  final FoodWastePost post;

  const DetailScreen({Key? key, required this.post, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, backButton: true),
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
                label: 'Image of discarded food items',
              ),
              Spacer(),
              Semantics(
                child: Text('${post.quantity.toString()} items',
                    style: Theme.of(context).textTheme.headline4),
                textField: true,
                readOnly: true,
                label: 'The number of discarded items',
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
