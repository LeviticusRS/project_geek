import 'package:flutter/material.dart';
import 'package:project_geek/screens/edit_screen.dart';
import 'package:project_geek/screens/home_screen.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      routes: {
        homeScreen: (context) => const ProfileScreen(title: "My Profile"),
        editScreen: (context) => const EditScreen(title: "Edit Profile"),
      },
    );
  }
}