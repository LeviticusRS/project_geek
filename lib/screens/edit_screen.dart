import 'package:flutter/material.dart';
import 'package:project_geek/constants.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit", style: TextStyle(color: Colors.white)),
          leading : IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22.0),
            tooltip: 'Go Back',
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
    );
  }
}

