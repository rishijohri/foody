import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp(
      {Key key = const Key("Error App"),
      this.child = const Text("Something Wrong",),})
      : super(key: key);
  final Text child;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Error",
        theme: FlexThemeData.light(scheme: FlexScheme.espresso),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.espresso),
        themeMode: ThemeMode.light,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Foody", style: Theme.of(context).textTheme.headline2,),
              ),
              Center(
                child: Text("Your food destination", style: Theme.of(context).textTheme.subtitle1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
