import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

/// The screen for creating a new food waste post.
class NewPostScreen extends StatefulWidget {
  /// The image picked from the user's image library.
  final XFile? pickedFile;

  const NewPostScreen({Key? key, required this.pickedFile}) : super(key: key);

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

/// The state of the screen for creating a new food waste post.
class NewPostScreenState extends State<NewPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? url;
  int quantity = 0;
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    uploadImage();
    locateUser();
  }

  /// Upload the image to Firebase storage and save its URL.
  void uploadImage() async {
    Reference ref =
        FirebaseStorage.instance.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(widget.pickedFile!.path));
    url = await (await uploadTask).ref.getDownloadURL();
    setState(() {});
  }

  /// Get the user's location.
  void locateUser() async {
    Location locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('New Post'),
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
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()])),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('New Post'),
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
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Semantics(
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(url!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                image: true,
                label: 'Image of wasted food items',
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 100.0,
                child: Semantics(
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Number of Wasted Items'),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    style: TextStyle(fontSize: 34),
                    textAlign: TextAlign.center,
                    onSaved: (value) {
                      if (value != null) {
                        quantity = int.parse(value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of wasted items';
                      }
                      return null;
                    },
                  ),
                  textField: true,
                  focusable: true,
                  label: 'Text field for entering the number of wasted items',
                ),
              ),
              Spacer(flex: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Semantics(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FirebaseFirestore.instance.collection('posts').add({
                          'date': DateTime.now(),
                          'imageURL': '${url!}',
                          'quantity': quantity,
                          'latitude': locationData.latitude,
                          'longitude': locationData.longitude
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Icon(Icons.cloud_upload, size: 80),
                  ),
                  button: true,
                  enabled: true,
                  label: 'Tap to submit post',
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
    }
  }
}
