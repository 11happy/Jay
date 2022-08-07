import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'about.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MenuWidget extends StatefulWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late RewardedAd rewardedAd;
  void initState() {
    super.initState();
  }

  void LoadmyAd() async {
    rewardedAd = RewardedAd(
      adUnitId: 'ca-app-pub-2597136798728787/3250472303',
      request: AdRequest(),
      listener: AdListener(
        onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
          print(reward.type);
          print(reward.amount);
        },
        onAdLoaded: (Ad ad) {
          rewardedAd.show();
          print('Ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
        // Called when a RewardedAd triggers a reward.
      ),
    );
    rewardedAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10),
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage("assets/imgs/icon.png"),
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 72.0),
                child: Center(
                  child: Text(
                    'Hi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 30,
                        fontFamily: 'BalsamiqSans'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Center(
                    child: Icon(
                  Ionicons.happy_outline,
                  size: 30,
                )),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {
                LoadmyAd();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  'assets/imgs/su.png',
                ),
                backgroundColor: Colors.white70,
              ),
              label: Text(
                "    Support Us       ",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAboutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  'assets/imgs/boy.png',
                ),
                backgroundColor: Colors.white70,
              ),
              label: Text(
                "About Developer",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  late String title;
  @override
  void initState() {
    title = "Home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderMenuContainer(
      appBarColor: Colors.white,
      key: _key,
      sliderMenuOpenSize: 200,
      title: Text(
        "Contribute",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
      ),
      sliderMenu: MenuWidget(
        onItemClick: (title) {
          _key.currentState!.closeDrawer();
          setState(() {
            this.title = title;
          });
        },
      ),
      sliderMain: new Container(
          width: double.infinity,
          color: Colors.white,
          child: new Opacity(
            opacity: 1,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 50.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset("assets/imgs/drive.png",
                        width: 200.0, height: 200.0),
                  ),
                ),
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 30.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding:
                        new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10),
                    child: new Text(
                      "Life is not accumulation",
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 21.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 30.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding:
                        new EdgeInsets.only(top: 0.0, bottom: 5.0, left: 7),
                    child: new Text(
                      "it is about ",
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 21.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 30.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding:
                        new EdgeInsets.only(top: 0.0, bottom: 5.0, left: 5),
                    child: new Text(
                      "Contribution ",
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 21.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 30.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 60.0, left: 0),
                    child: new Text(
                      "You can contribute your notes here",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'FlamanteRomaItalic',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      const url =
                          'https://drive.google.com/drive/folders/1uwuxiFkzj2gG07K8rlr1ME4gX2NqqW9J?usp=sharing';
                      launchURL(url);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink.shade100,
                        onPrimary: Colors.black,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        shadowColor: Colors.black),
                    icon: Icon(
                      Icons.arrow_upward,
                      size: 25,
                    ),
                    label: Text(
                      "Upload Here",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                new Transform(
                  transform:
                      new Matrix4.translationValues(0.0, 30.0 * (1.0 - 0), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(left: 7, bottom: 1),
                    child: new Text(
                      "Note : Do not upload any Copyrighted material here",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'FlamanteRomaBold',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
