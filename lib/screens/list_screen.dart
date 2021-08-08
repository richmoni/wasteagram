import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPostScreen(pickedFile: pickedFile)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called rawPosts that references the firestore collection
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
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
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
                    child: ListTile(
                      title: Text(post.formattedDate),
                      trailing: Text(post.quantity.toString(),
                          style: Theme.of(context).textTheme.headline4),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(post: post)),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Create a New Post',
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
