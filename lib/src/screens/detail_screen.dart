import 'package:flutter/material.dart';
import 'package:wasteagram/src/models/db_message.dart';
import 'package:wasteagram/src/widgets/custom_app_bar.dart';

/// The detail screen for a food waste post.
class DetailScreen extends StatelessWidget {
  /// The title of the app bar.
  final String title;

  /// The food waste post to display.
  final DbMessage msg;

  const DetailScreen({Key? key, required this.msg, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, backButton: true),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
        child: Center(
          child: Column(
            children: [
              Semantics(
                child: Text(msg.abbreviatedDate, style: Theme.of(context).textTheme.headline4),
                readOnly: true,
                label: 'Submission date',
              ),
              Spacer(),
              Semantics(
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(msg.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                image: true,
                label: 'Image of discarded food items',
              ),
              Spacer(),
              Semantics(
                child: Text('${msg.quantity.toString()} ${msg.quantity == 1 ? "item" : "items"}',
                    style: Theme.of(context).textTheme.headline4),
                readOnly: true,
                label: 'The number of discarded items',
              ),
              Spacer(),
              Semantics(
                child: Text('Location: (${msg.formattedLatitude}, ${msg.formattedLongitude})'),
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
