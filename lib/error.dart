import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Text(
            "Oops !",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.2),
        leading: IconButton(
          color: Colors.black,
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(EvaIcons.arrowLeft),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/imgs/asd.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Colors.black.withOpacity(0.17),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
