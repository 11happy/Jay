import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui';
import 'package:jay/constants/Theme.dart';

import 'package:jay/page1.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:connectivity/connectivity.dart';
import 'error.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: LoginPageWidget()));
}

class LoginPageWidget extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool ic = false;
  late StreamSubscription sub;

  late FirebaseAuth _auth;

  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    sub = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        ic = (result != ConnectivityResult.none);
      });
    });

    initApp();
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser!;
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => BottomNavBar(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user!;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (isUserSignedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      );
    } else {
      return Scaffold(
          body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imgs/kopi4.jpg"),
                      fit: BoxFit.cover))),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          child: Center(
                              child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text("Chemistry",
                                      style: TextStyle(
                                          color: NowUIColors.black,
                                          fontWeight: FontWeight.w600)))),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text("Notes",
                                    style: TextStyle(
                                        color: NowUIColors.black,
                                        fontWeight: FontWeight.w600)),
                              ))
                        ],
                      ))),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Designed & Coded By",
                              style: TextStyle(
                                  color: NowUIColors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Happy",
                              style: TextStyle(
                                  color: NowUIColors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  if (ic) {
                                    _handleSignIn();
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Error()),
                                    );
                                  }
                                },
                                child: new Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 175,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 12),
                                        child: Center(
                                          child: Text(
                                            'Sign up',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(65),
                                              topLeft: Radius.circular(65),
                                              bottomRight: Radius.circular(200),
                                            )),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Icon(
                                          EvaIcons.google,
                                          size: 28,
                                        ),
                                      )
                                    ],
                                  ),
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent.shade200,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("OR",
                              style: TextStyle(
                                  color: NowUIColors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      SizedBox(
                        height: 50,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            if (ic) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Error()),
                              );
                            }
                          },
                          child: new Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 175,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  child: Center(
                                    child: Text(
                                      'Guest Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(65),
                                        topLeft: Radius.circular(65),
                                        bottomRight: Radius.circular(200),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Icon(
                                    EvaIcons.person,
                                    size: 29,
                                  ),
                                )
                              ],
                            ),
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ));
    }
  }

}


