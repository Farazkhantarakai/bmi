import 'package:flutter/material.dart';

class ProgressIndication extends StatelessWidget {
  const ProgressIndication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 400,
      height: 100,
      child: Stack(
        children: [
          const Positioned(
            left: 7,
            child: Text(
              'UnderWeight',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            left: 150,
            child: Text(
              'Normal',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            right: 20,
            child: Text('OverWeight',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Stack(children: const [
              LinearProgressIndicator(
                minHeight: 7,
                value: 0.20,
                backgroundColor: Colors.blue,
                color: Colors.blueGrey,
              ),
              LinearProgressIndicator(
                  minHeight: 7,
                  value: 0.70,
                  // backgroundColor: Colors.amberAccent,
                  color: Colors.greenAccent),
              LinearProgressIndicator(
                minHeight: 7,
                value: 0.36,
                backgroundColor: Colors.transparent,
                color: Colors.pink,
              ),
            ]),
          ),
          const Positioned(
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    '16.0',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))),
          const Positioned(
              left: 115,
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    '18.5',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          const Positioned(
              right: 96,
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    '25.0',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          const Positioned(
              right: 2,
              child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    '40.0',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
