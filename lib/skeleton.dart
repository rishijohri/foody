import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:foody/profile_page.dart';
import 'package:foody/search_page.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'sign.dart';
import 'profile_page.dart';
// ignore: must_be_immutable
class SkeletonApp extends StatelessWidget {
  SkeletonApp({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foody_Main_Activity",
      theme: FlexThemeData.light(scheme: FlexScheme.mango),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mango),
      themeMode: ThemeMode.light,
      home: auth.currentUser==null ? const Sign() : const Skeleton(),
    );
  }
}

class Skeleton extends StatefulWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            HomePage(),
            const SearchPage(),
            ProfilePage(),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        items: [
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).colorScheme.secondary),
          BottomNavyBarItem(
              icon: const Icon(Icons.search_rounded),
              title: const Text("Search"),
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: Theme.of(context).colorScheme.secondary),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: Theme.of(context).colorScheme.secondary)
        ],
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          });
        },
      ),
    );
  }
}
