import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'error_page.dart';
import 'skeleton.dart';
import 'sign.dart';
void main() {
  runApp(const ConnectionApp());
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
          return const ErrorApp();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          sleep(const Duration(seconds: 2));
          return SkeletonApp();
        }
        return ErrorApp(
          child: Text("Unknown Error", style: Theme.of(context).textTheme.headline2),
        );
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
