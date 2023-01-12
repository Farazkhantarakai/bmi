import 'package:flutter/material.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({Key? key}) : super(key: key);
  static const routName = 'informationPage';

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bmi Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.63,
            decoration: BoxDecoration(
                border: Border.all(
              width: 5,
              color: Colors.deepOrange,
            )),
            child: SingleChildScrollView(
              child: DataTable(columns: const [
                DataColumn(
                    label: Text(
                  'Category',
                  style: TextStyle(color: Colors.green),
                )),
                DataColumn(
                    label: Text(
                  'difference',
                  style: TextStyle(color: Colors.green),
                ))
              ], rows: const [
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Very Severly underweight',
                      style:
                          TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                    ),
                  ),
                  DataCell(Text(
                    '<15',
                    style: TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Severly Underweight',
                      style:
                          TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                    ),
                  ),
                  DataCell(Text(
                    '16.0-16.9',
                    style: TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Underweight',
                      style:
                          TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                    ),
                  ),
                  DataCell(Text(
                    '17.0-18.4',
                    style: TextStyle(color: Color.fromARGB(255, 105, 121, 240)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Normal',
                      style: TextStyle(color: Color.fromARGB(255, 0, 29, 53)),
                    ),
                  ),
                  DataCell(Text(
                    '18.5.0-24.9',
                    style: TextStyle(color: Color.fromARGB(255, 0, 29, 53)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Overweight',
                      style: TextStyle(color: Color.fromARGB(225, 238, 36, 53)),
                    ),
                  ),
                  DataCell(Text(
                    '25.0<29.9',
                    style: TextStyle(color: Color.fromARGB(221, 238, 36, 53)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Obese class |',
                      style: TextStyle(color: Color.fromARGB(255, 230, 41, 41)),
                    ),
                  ),
                  DataCell(Text(
                    '25.0-29.9',
                    style: TextStyle(color: Color.fromARGB(255, 230, 41, 41)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Obese class ||',
                      style: TextStyle(color: Color.fromARGB(255, 211, 55, 55)),
                    ),
                  ),
                  DataCell(Text(
                    '35.0-39.9',
                    style: TextStyle(color: Color.fromARGB(255, 221, 61, 61)),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(
                    Text(
                      'Obese Class |||',
                      style: TextStyle(color: Color.fromARGB(255, 221, 61, 61)),
                    ),
                  ),
                  DataCell(Text(
                    '40 > ',
                    style: TextStyle(color: Color.fromARGB(255, 221, 61, 61)),
                  ))
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
