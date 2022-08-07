import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'secondpage1.dart';
import 'secondpage2.dart';
import 'package:flutter/widgets.dart';
import 'package:jay/utils/go_icons.dart';
import 'package:jay/second_page.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Contribute.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class MenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundImage: AssetImage('assets/imgs/gamer.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Ahoy!',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'BalsamiqSans'),
          ),
          SizedBox(
            height: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          Text(
            "Home",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'BalsamiqSans'),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int position = 0;
  List l1 = [
    SecondPage1(),
    SecondPage(),
    SecondPage2(),
    Page1(),
  ];
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
        bottomNavigationBar: BottomNavyBar(
          animationDuration: Duration(milliseconds: 350),
          containerHeight: 60,
          backgroundColor: const Color(0xFFFFFFFF).withOpacity(1),
          selectedIndex: position,
          onItemSelected: (index) {
            Feedback.forTap(context);
            setState(() {
              position = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(
                Go.pouy1,
                size: 30,
              ),
              title: Text("Organic", style: TextStyle(fontSize: 15)),
              inactiveColor: Colors.black,
              activeColor: Colors.deepPurple,
            ),
            BottomNavyBarItem(
                icon: Icon(
                  Go.atom__1_,
                  size: 30,
                ),
                title: Text("Inorganic", style: TextStyle(fontSize: 15)),
                activeColor: Colors.indigo,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(
                  Go.cube,
                  size: 30,
                ),
                title: Text("Physical", style: TextStyle(fontSize: 15)),
                activeColor: Colors.orange,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              title: Text("Contribute", style: TextStyle(fontSize: 15)),
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.black,
            ),
          ],
        ),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            SecondPage1(),
            SecondPage(),
            SecondPage2(),
            Page1(),
          ],
        ));
  }
}
