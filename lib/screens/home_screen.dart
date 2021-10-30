import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:io' show File, Platform;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ImageProvider imageFile = const ExactAssetImage('assets/default.jpg');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text("My Profile", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder(future: _profileFile,
                                    builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                                      return snapshot.data != null ? Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue,
                                                width: 2.5
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: Image.file(snapshot.data!).image,
                                              fit: BoxFit.cover,
                                            ),
                                          )) : Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue,
                                                width: 2.5
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageFile,
                                              fit: BoxFit.cover,
                                            ),
                                          ));
                                    }),
                              ],
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.only(top: 0.0, left: 95.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                      radius: 25.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.white, size: 22.0),
                                        tooltip: 'Go Back',
                                        onPressed: () {
                                          setState(() {
                                            if (Platform.isAndroid) {
                                              _getFromGallery();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    final file = await _profileFile;
    setState(() {
      if (image != null) {
        imageFile = Image.file(File(image.path)).image;
        file.writeAsBytesSync(File(image.path).readAsBytesSync());
      }
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _profileFile async {
    final path = await _localPath;
    return File('$path/profile.jpg');
  }
}
