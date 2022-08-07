import 'dart:async';
import 'dart:math';
import 'package:ionicons/ionicons.dart';

import 'about.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String skipLastChar(String text) {
  return text.substring(0, max(0, text.length - 4));
}

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
        adUnitId: "ca-app-pub-2597136798728787/3250472303",
        listener: AdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            rewardedAd.show();
            print('Ad loaded.');
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            rewardedAd.dispose();

            print('Ad failed to load: $error');
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) => print('Ad opened.'),
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {
            rewardedAd.dispose();
            print('Ad closed.');
          },
          // Called when an ad is in the process of leaving the application.
          onApplicationExit: (Ad ad) => print('Left application.'),
          // Called when a RewardedAd triggers a reward.
          onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
            print('Reward earned: $reward');
          },
        ),
        request: AdRequest());
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
                  size: 32,
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

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text('Swipe to View'),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blue,
                      ),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).cachedFromUrl(
        url,
        placeholder: (double progress) => Stack(children: [
          SpinKitDualRing(color: Colors.black45,size: 50,lineWidth: 4,),
          Center(child: Text('$progress %')),
        ],),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '<',
                  backgroundColor: Colors.blue,
                  child: const Text('<'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  heroTag: '>',
                  child: const Text('>'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List<FirebaseFile>> futureFiles;
  late String title;

  @override
  void initState() {
    title = "Home";
    super.initState();
    futureFiles = FirebaseApi.listAll('Inorganic/');
  }

  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
        appBarColor: Colors.white,
        key: _key,
        sliderMenuOpenSize: 200,
        title: Text(
          "Inorganic",
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
        sliderMain: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: SpinKitThreeBounce(
                  color: Colors.blueAccent,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  // ignore: non_constant_identifier_names
                  final Inorganic = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          thickness: 5,
                          child: ListView.builder(
                            itemCount: Inorganic.length,
                            itemBuilder: (context, index) {
                              final file = Inorganic[index];

                              return buildFile(context, file);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

final Color c = Colors.transparent;
final Color q = Colors.transparent;

Widget buildFile(BuildContext context, FirebaseFile file) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerCachedFromUrl(
                    url: file.url,
                  ),
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(2)),
                Container(
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Colors.indigo,
                      Colors.indigoAccent,
                      Colors.blue,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          skipLastChar(file.name),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
