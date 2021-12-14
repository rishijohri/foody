import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'skeleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? prtext = "Sign Up or Sign In";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? curr;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
    curr = auth.currentUser;
    if (curr != null) {
    } else {
      print("no user");
      print("user");
    }
    if (curr?.email != null) {
      prtext = curr!.displayName;
    } else {
      prtext = "Sign Up or Sign In";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(prtext!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryVariant,
                          fontWeight: FontWeight.bold,
                          fontSize: Theme.of(context)
                              .textTheme
                              .headline4!
                              .fontSize),
                  ),
                ),
              ),
              Image(
                image:const AssetImage("assets/images/minimal_mango.png"),
                height: MediaQuery.of(context).size.height*0.3,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize),
                          ),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIN(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize),
                          ),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController();
  TextEditingController display = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorText = "";
  bool passwordObscure = true;
  @override
  void initState() {
    super.initState();
    passwordObscure = true;
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  Future<void> registration() async {
    bool ahead = true;
    String tmpError = "Unable to Sign In";
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
    } on FirebaseAuthException catch (e) {
      tmpError = e.code;
      ahead = false;
    } catch (e) {
      ahead = false;
    } finally {
      if (ahead) {
        setState(() {
          errorText = "Success !!";
        });
        CollectionReference userData = firestore.collection("UserDatas");
        auth.currentUser?.updateDisplayName(display.text);
        DocumentReference userRef = await userData.add({
          "name": display.text,
          "email": email.text,
        });
        await userRef.update(
            {"auth_id": auth.currentUser == null ? 0 : auth.currentUser!.uid});
        await firestore.runTransaction((transaction) async {
          transaction.set(userRef.collection("History").doc(), {
            "date": DateTime.now(),
            "amount": 0,
            "items": [],
          });
        });
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Skeleton()));
      } else {
        setState(() {
          errorText = tmpError;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    labelText: "E-Mail"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: display,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: pass,
                obscureText: passwordObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      !passwordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  labelText: "Password",
                ),
              ),
            ),
            MaterialButton(
              onPressed: registration,
              color: Theme.of(context).colorScheme.secondary,
              child:
                  Text("Submit", style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorText,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignIN extends StatefulWidget {
  const SignIN({Key? key}) : super(key: key);

  @override
  _SignINState createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String errorText = "";
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool passwordObscure = true;
  @override
  void initState() {
    super.initState();
    passwordObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    labelText: "E-Mail"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: pass,
                obscureText: passwordObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      !passwordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  labelText: "Password",
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                bool ahead = true;
                String tmperr = "Unable to sign in, try again later";
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text, password: pass.text);
                } on FirebaseAuthException catch (e) {
                  ahead = false;
                  tmperr = e.code;
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                } catch (e) {
                  print(e);
                } finally {
                  if (ahead) {
                    setState(() {
                      errorText = "Success !!!";
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Skeleton()));
                  } else {
                    setState(() {
                      errorText = tmperr;
                    });
                  }
                }
              },
              color: Theme.of(context).colorScheme.secondary,
              child:
                  Text("Submit", style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorText,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
