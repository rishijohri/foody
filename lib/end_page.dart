import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key key = const Key("End Page"),
    this.child = const Text(
      "Something Wrong",
    ),
  }) : super(key: key);
  final Text child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Error",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Center(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Foody",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.headline1!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
              Image(
              image:const AssetImage("assets/images/minimal_mango.png"),
              height: MediaQuery.of(context).size.height*0.3,
            ),
            Center(
              child: Text(
                "Your food destination",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
