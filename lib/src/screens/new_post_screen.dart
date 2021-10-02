import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/src/widgets/custom_app_bar.dart';

/// The interface for creating a new food waste post.
class NewPostScreen extends StatefulWidget {
  /// The image picked from the user's image library.
  final XFile? pickedFile;

  const NewPostScreen({Key? key, required this.pickedFile}) : super(key: key);

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String _title = 'New Post';
  late LocationData _locationData;
  String? _imageURL;
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    uploadImage();
    locateUser();
  }

  /// Upload the image to Firebase storage and save its URL.
  void uploadImage() async {
    // Obtain a reference to the Firebase Storage bucket and upload the image.
    Reference ref = FirebaseStorage.instance.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(widget.pickedFile!.path));
    _imageURL = await (await uploadTask).ref.getDownloadURL();
    // Trigger rebuild after image has been uploaded.
    setState(() {});
  }

  /// Get the user's location.
  void locateUser() async {
    Location locationService = Location();
    _locationData = await locationService.getLocation();
    // Trigger rebuild after location has been found.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Display progress indicator until image has been uploaded.
    if (_imageURL == null) {
      return Scaffold(
        appBar: CustomAppBar(title: _title, backButton: true),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()])),
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(title: _title, backButton: true),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Semantics(
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_imageURL!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                image: true,
                label: 'Image of discarded food items',
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40.0,
                height: 100.0,
                child: Semantics(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Number of Discarded Items'),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    style: TextStyle(fontSize: 34),
                    textAlign: TextAlign.center,
                    onSaved: (value) {
                      if (value != null) {
                        _quantity = int.parse(value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of discarded items';
                      }
                      return null;
                    },
                  ),
                  textField: true,
                  focusable: true,
                  label: 'Text field for entering the number of discarded items',
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
                        // Save the form fields and insert the new post into the Firestore database.
                        _formKey.currentState!.save();
                        FirebaseFirestore.instance.collection('posts').add({
                          'date': DateTime.now(),
                          'imageURL': '${_imageURL!}',
                          'quantity': _quantity,
                          'latitude': _locationData.latitude,
                          'longitude': _locationData.longitude
                        });
                        // Return to the list screen.
                        Navigator.of(context).pop();
                      }
                    },
                    child: Icon(Icons.cloud_upload, size: 80.0),
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
