import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:io' show File, Platform;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_geek/constants.dart';
import 'package:project_geek/models/type.dart';
import 'package:project_geek/models/user.dart';

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
    _loadProfileJson();
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
                                FutureBuilder(future: _profileImageFile,
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
                                        tooltip: 'Edit Photo',
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
                        ),
                        buildFirstName(),
                        buildLastName(),
                        buildEmail(),
                        buildPhoneNumber(),
                        buildBiography(),
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
    final file = await _profileImageFile;
    setState(() {
      if (image != null) {
        imageFile = Image.file(File(image.path)).image;
        file.writeAsBytesSync(File(image.path).readAsBytesSync());
      }
    });
  }

  _writeProfileJson() async {
    final file = await _profileInfoFile;
    setState(() {
      file.writeAsString(jsonEncode(user));
    });
  }

  _loadProfileJson() async {
    final file = await _profileInfoFile;
    if (file.existsSync()) {
      setState(() {
        Map<String, dynamic> userMap = jsonDecode(file.readAsStringSync());
        user = User.fromJson(userMap);
      });
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _profileImageFile async {
    final path = await _localPath;
    return File('$path/profile.jpg');
  }

  Future<File> get _profileInfoFile async {
    final path = await _localPath;
    return File('$path/profile.json');
  }

  Widget buildBiography() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biography',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          _inputDialogue(context, Type.biography);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.biography,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
  Widget buildFirstName() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'First Name',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          _inputDialogue(context, Type.firstName);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.firstName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
  Widget buildLastName() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last Name',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          _inputDialogue(context, Type.lastName);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.lastName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
  Widget buildPhoneNumber() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          _inputDialogue(context, Type.phoneNumber);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
  Widget buildEmail() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          _inputDialogue(context, Type.email);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _inputDialogue(BuildContext context, Type type) async {
    _textFieldController.clear();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${type.displayTitle}'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "${type.displayTitle}"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                String value = _textFieldController.value.text;
                switch (type) {
                  case Type.firstName:
                    if (value.isValidName) {
                      user.firstName = value;
                    }
                    break;
                  case Type.lastName:
                    if (value.isValidName) {
                      user.lastName = value;
                    }
                    break;
                  case Type.email:
                    if (value.isValidEmail) {
                      user.email = value;
                    }
                    break;
                  case Type.phoneNumber:
                    if (value.isValidPhone) {
                      user.phoneNumber = value;
                    }
                    break;
                  case Type.biography:
                    user.biography = _textFieldController.value.text;
                    break;
                }

                _writeProfileJson();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
