import './arrange_space.dart';
import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  const BmiResult(
      {Key? key,
      required this.data,
      required this.weightType,
      this.color = Colors.red})
      : super(key: key);
  final double data;
  final String weightType;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    data.toStringAsFixed(2),
                    style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'BMI',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrangeAccent),
                ),
                const Space(
                  heightOfWidget: 5,
                ),
                Text(
                  weightType,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
