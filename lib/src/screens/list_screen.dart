import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/src/models/db_message.dart';
import 'package:wasteagram/src/screens/detail_screen.dart';
import 'package:wasteagram/src/screens/new_post_screen.dart';
import 'package:wasteagram/src/widgets/custom_app_bar.dart';

/// A list view of all food waste posts.
class ListScreen extends StatefulWidget {
  /// The title of the app bar.
  final String title;

  ListScreen({Key? key, required this.title}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  /// Image picker instance for picking images from the image library.
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from the image library.
  void pickImage() async {
    final XFile? _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPostScreen(pickedFile: _pickedFile)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the posts collection from the Firestore database.
    CollectionReference _documents = FirebaseFirestore.instance.collection('posts');

    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Center(
        child: StreamBuilder(
            stream: _documents.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.hasData &&
                  snapshot.data!.size > 0) {
                // Map the Firestore documents to a list of food waste posts.
                final List<DbMessage> _messages = snapshot.data!.docs.map((document) {
                  return DbMessage(
                      date: document['date'].toDate(),
                      imageURL: document['imageURL'],
                      quantity: document['quantity'],
                      latitude: document['latitude'],
                      longitude: document['longitude']);
                }).toList();
                return ListView(
                  children: _messages.map((msg) {
                    return Center(
                      child: Semantics(
                        child: ListTile(
                          title: Text(msg.formattedDate),
                          trailing: Text(msg.quantity.toString(),
                              style: Theme.of(context).textTheme.headline4),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(title: widget.title, msg: msg)),
                            );
                          },
                        ),
                        readOnly: true,
                        label: 'Tap to see post details',
                      ),
                    );
                  }).toList(),
                );
              }
              // Display progress indicator if connection is inactive or collection is empty.
              return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircularProgressIndicator(),
              ]);
            }),
      ),
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: pickImage,
          tooltip: 'Create a New Post',
          child: Icon(Icons.camera_alt),
        ),
        button: true,
        enabled: true,
        label: 'Tap to create a new post',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
