import 'package:jay/utils/colors.dart';
import 'package:jay/utils/text_styles.dart';
import 'package:jay/utils/ui_helpers.dart';
import 'package:jay/widgets/sexy_tile.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  List<String> itemContent = [
    'About me',
    'I am happy but records say Bhuminjay Soni, Aah nevermind u can call me either :) ,will not introduce myself in this boring way (Currently a first year CSE student at IIT JODHPUR blah blah.....).\n\n I am simple guy with simple(Although sometimes weird) daily routine like any other person…\nBut I can say that I am kind, ready to help someone type person… I feel proud of having my such a lovely family…and i am blessed with two eyes(with specs actually)…nose, two ears…I am very thankful to god…\nHave a lot of Dreams....\nThat \'s all…I guess…anything left?…\nUmmmm…..Ooo…yah I love walking and cycling …more than any sport…\nI love spending time with my cousins,friends and Family.\nI love to be your friend if you wish :)\nThnx\n\n',
    'Gratitude',
    'Thanks to all OP seniors I have got in touch with.\n\nSpecial thanks to my Family for always supporting and guiding me.',
  ];
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invertInvertColorsStrong(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 50.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(EvaIcons.arrowIosBack),
                    tooltip: 'Go back',
                    color: invertColorsStrong(context),
                    iconSize: 26.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'About',
                      style: isThemeCurrentlyDark(context)
                          ? TitleStylesDefault.white
                          : TitleStylesDefault.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: 'tile2',
                    child: SexyTile(
                      color: Colors.white,
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 55,
                              backgroundColor:
                                  invertInvertColorsStrong(context),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/imgs/happyt.jpg'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.code,
                                  color: invertColorsMild(context),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  'with',
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Icon(
                                  EvaIcons.heart,
                                  color: MyColors.heart,
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  'by',
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Happy',
                              style: isThemeCurrentlyDark(context)
                                  ? LabelStyles.white
                                  : LabelStyles.black,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.facebook,
                                    color: Colors.indigo,
                                    size: 27.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://www.facebook.com/bhuminjay.soni/'),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Ionicons.logo_instagram,
                                      color: Colors.pinkAccent,
                                      size: 27.0,
                                    ),
                                    onPressed: () {
                                      const url =
                                          'https://www.instagram.com/11happy._.5/';
                                      launchURL(url);
                                    }),
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.twitter,
                                    color: MyColors.twitter,
                                    size: 27.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://twitter.com/Happy87143815/'),
                                ),
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.browser,
                                    color: Colors.amber,
                                    size: 27.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://11happy.github.io/1.github.io/'),
                                ),
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.linkedin,
                                    color: Colors.indigoAccent,
                                    size: 27.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://www.linkedin.com/in/bhuminjay-soni-968145209/'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      splashColor: MyColors.accent,
                    ),
                  ),
                  SexyTile(
                    onTap: () {},
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            itemContent[0],
                            style: HeadingStylesDefault.accent,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            itemContent[1],
                            style: isThemeCurrentlyDark(context)
                                ? BodyStylesDefault.white
                                : BodyStylesDefault.black,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    splashColor: MyColors.accent,
                  ),
                  SexyTile(
                    onTap: () {},
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            itemContent[2],
                            style: HeadingStylesDefault.accent,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            itemContent[3],
                            style: isThemeCurrentlyDark(context)
                                ? BodyStylesDefault.white
                                : BodyStylesDefault.black,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    splashColor: MyColors.accent,
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(
          EvaIcons.github,
          size: 36.0,
        ),
        tooltip: 'View GitHub repo',
        foregroundColor: invertInvertColorsStrong(context),
        backgroundColor: invertColorsStrong(context),
        elevation: 5.0,
        onPressed: () => launchURL('https://github.com/11happy'),
      ),
    );
  }
}
