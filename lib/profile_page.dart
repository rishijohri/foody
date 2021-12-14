import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? preText;
  User? curr;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
    curr = auth.currentUser;
    print(curr!.uid);

    if (curr?.displayName != null) {
      preText = curr!.displayName;
    } else {
      preText = "User";
    }
  }

  Future<void> logout() async {
    auth.signOut();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Sign();
    }));
  }

  Future<void> history() async {}
  Future<void> feedback() async {}
  Future<void> details() async {}
  @override

  Widget build(BuildContext context) {
    firestore.collection("UserDatas").where("auth_id", isEqualTo: curr!.uid).get().then((value) {
      print(value.docs.length);
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: Text(
                    "Welcome \n" + preText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Details",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: logout,
                  title: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: history,
                  title: Text(
                    "View Order History",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: feedback,
                  title: Text(
                    "Feedback",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
