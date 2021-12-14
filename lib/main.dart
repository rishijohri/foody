import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'end_page.dart';
import 'skeleton.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'sign.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foody_Main_Activity",
      theme: FlexThemeData.light(scheme: FlexScheme.mango),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mango),
      themeMode: ThemeMode.light,
      home: const ConnectionApp(),
    );
  }
}

class ConnectionApp extends StatefulWidget {
  const ConnectionApp({Key key = const Key("unknown")}) : super(key: key);

  @override
  _ConnectionAppState createState() => _ConnectionAppState();
}

class _ConnectionAppState extends State<ConnectionApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const ErrorPage();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          sleep(const Duration(seconds: 3));
          return SkeletonApp();
        }
        return const IntroPage();
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}


