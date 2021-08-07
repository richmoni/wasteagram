import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';

class NewPostScreen extends StatefulWidget {
  final url;

  const NewPostScreen({Key? key, required this.url}) : super(key: key);

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int quantity = 0;
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New Post'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 100.0,
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
            ),
            Spacer(flex: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FirebaseFirestore.instance.collection('posts').add({
                      'date': DateTime.now(),
                      'imageURL': '${widget.url}',
                      'quantity': quantity,
                      'latitude': locationData.latitude,
                      'longitude': locationData.longitude
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Icon(Icons.cloud_upload, size: 80),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
