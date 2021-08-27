import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/src/models/food_waste_post.dart';
import 'package:wasteagram/src/screens/detail_screen.dart';
import 'package:wasteagram/src/screens/new_post_screen.dart';

/// A list view of all food waste posts.
class ListScreen extends StatefulWidget {
  ListScreen({Key? key, required this.title}) : super(key: key);

  /// The [AppBar] title.
  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  /// Image picker instance for picking images from the image library.
  final ImagePicker picker = ImagePicker();

  /// Pick an image from the image library.
  void getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPostScreen(pickedFile: pickedFile)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference that references the firestore collection.
    CollectionReference rawPosts =
        FirebaseFirestore.instance.collection('posts');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: rawPosts.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.size > 0) {
                  final List<FoodWastePost> _posts =
                      snapshot.data!.docs.map((post) {
                    return FoodWastePost(
                        date: post['date'].toDate(),
                        imageURL: post['imageURL'],
                        quantity: post['quantity'],
                        latitude: post['latitude'],
                        longitude: post['longitude']);
                  }).toList();
                  return ListView(
                    children: _posts.map((post) {
                      return Center(
                        child: Semantics(
                          child: ListTile(
                            title: Text(post.formattedDate),
                            trailing: Text(post.quantity.toString(),
                                style: Theme.of(context).textTheme.headline4),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(post: post)),
                              );
                            },
                          ),
                          label: 'Tap to see post details',
                          readOnly: true,
                        ),
                      );
                    }).toList(),
                  );
                }
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ]);
            }),
      ),
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: getImage,
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
