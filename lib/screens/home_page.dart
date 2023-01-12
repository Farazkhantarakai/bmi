import './result_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;
  bool isAdBannerReady = false;

  int interstitialLoadAttempts = 0;
  bool isMale = false;
  bool isFemale = false;
  String gender = '';
  bool changeRow = true;
  bool weightRowChange = true;
  var height = ['cm', 'ft'];
  var heightValue = 'cm';
  var weight = ['Kg', 'Ib'];
  var weightValue = 'Kg';
  double bmiCal = 0.0;
  final _heighController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _footController = TextEditingController();
  final _inchesController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    loadAds();
    super.initState();
  }

  loadAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5769137860547781/7223898919",
        listener: BannerAdListener(
            onAdLoaded: ((ad) {
              if (kDebugMode) {
                setState(() {
                  isAdBannerReady = true;
                });
                Fluttertoast.showToast(msg: 'Add is loaded');
              }
            }),
            onAdClosed: (ad) {},
            onAdFailedToLoad: ((ad, error) {
              ad.dispose();
              isAdBannerReady = false;
              if (kDebugMode) {
                Fluttertoast.showToast(
                    msg: "failed to load ads",
                    backgroundColor: Colors.deepOrange);
                ad.dispose();
              }
            })),
        request: const AdRequest());

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      bottomNavigationBar: isAdBannerReady
          ? Container(
              decoration: const BoxDecoration(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Body Mass Index (BMI)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Select Your Gender',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            // Image.asset('assets/icons/male.png')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isFemale) {
                        isFemale = !isFemale;
                        isMale = !isMale;
                        gender = 'male';
                      } else if (!isMale) {
                        isMale = !isMale;
                        gender = 'male';
                      } else {
                        isMale = !isMale;
                        gender = '';
                      }
                      if (kDebugMode) {
                        print('male section  $gender');
                      }
                      // print(gender);
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      constraints: !isLandScape
                          ? const BoxConstraints.expand(width: 160, height: 200)
                          : const BoxConstraints.expand(
                              width: 160, height: 150),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 5,
                              color: isMale ? Colors.green : Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Male',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/icons/male.png')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isMale) {
                        isMale = !isMale;
                        isFemale = !isFemale;
                        gender = 'female';
                      } else if (!isFemale) {
                        isFemale = !isFemale;
                        gender = 'female';
                      } else {
                        isFemale = !isFemale;
                        gender = '';
                      }
                      if (kDebugMode) {
                        print('female section $gender');
                      }
                      // isFemale = !isFemale;
                      // gender = 'female';
                      // print(gender);
                    });
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      // margin: const EdgeInsets.only(top: 10),
                      constraints: !isLandScape
                          ? const BoxConstraints.expand(width: 160, height: 200)
                          : const BoxConstraints.expand(
                              width: 160, height: 150),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 5,
                              color:
                                  isFemale ? Colors.deepOrange : Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Female',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/icons/female.png')
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: _form,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'field are empty';
                            }
                            return null;
                          },
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Enter Your Age'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                // Container(
                                //   width: double.infinity,
                                //   height: 50,
                                //   color: Colors.red,
                                // )
                                changeRow
                                    ? Row(children: [
                                        Expanded(
                                          flex: 4,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return 'height field is empty';
                                              }
                                              return null;
                                            },
                                            controller: _heighController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'Height'),
                                          ),
                                        )
                                      ])
                                    : Row(children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                              validator: (value) {
                                                if (value.toString().isEmpty) {
                                                  return 'ft field is empty';
                                                }
                                                return null;
                                              },
                                              controller: _footController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  hintText: 'ft')),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextFormField(
                                              validator: (value) {
                                                if (value.toString().isEmpty) {
                                                  return 'Inches should not be empty';
                                                }
                                                return null;
                                              },
                                              controller: _inchesController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  hintText: 'Inches')),
                                        ),
                                      ])
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                // Container(
                                //   width: 100,
                                //   height: 50,
                                //   color: Colors.blue,
                                // )

                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      heightValue = value.toString();
                                      if (heightValue == 'cm') {
                                        changeRow = true;
                                      }
                                      if (heightValue == 'ft') {
                                        changeRow = false;
                                      }
                                    });
                                  },
                                  value: heightValue,
                                  focusColor: Colors.white,
                                  items: height
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                // Container(
                                //   width: double.infinity,
                                //   height: 50,
                                //   color: Colors.red,
                                // )
                                Row(children: [
                                  Expanded(
                                    flex: 4,
                                    child: weightRowChange
                                        ? TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Weight field should not be empty';
                                              }
                                              return null;
                                            },
                                            controller: _weightController,
                                            textInputAction: TextInputAction.go,
                                            // onFieldSubmitted: (value) {
                                            //   FocusScope.of(context)
                                            //       .requestFocus(_ageFocus);
                                            // },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'Weight'))
                                        : TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Pound field should not be empty';
                                              }
                                              return null;
                                            },
                                            controller: _weightController,
                                            textInputAction: TextInputAction.go,
                                            // onFieldSubmitted: (value) {
                                            //   FocusScope.of(context)
                                            //       .requestFocus(_ageFocus);
                                            // },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'Pound')),
                                  )
                                ])
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                // Container(
                                //   width: 100,
                                //   height: 50,
                                //   color: Colors.blue,
                                // )

                                DropdownButtonFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      weightValue = value.toString();
                                      if (weightValue == 'Kg') {
                                        weightRowChange = true;
                                      }
                                      if (weightValue == 'Ib') {
                                        weightRowChange = false;
                                      }
                                    });
                                  },
                                  value: weightValue,
                                  focusColor: Colors.white,
                                  items: weight
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.grey,
                                  primary: Colors.white,
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 90,
                                      right: 90)),
                              onPressed: () {
                                double weight = 0.0;
                                double height =
                                    0.0; // donot assign a value of int
                                if (_form.currentState!.validate()) {
                                  if (heightValue == 'ft') {
                                    var feetInDouble = double.parse(
                                        _footController.text.toString());
                                    var inchesInDouble = double.parse(
                                        _inchesController.text.toString());
                                    height = convertToMeter(
                                        feetInDouble, inchesInDouble);
                                    // print('i am here in ft $height');
                                  }
                                  if (weightValue == 'Ib') {
                                    weight =
                                        convertIbToKg(_weightController.text);
                                    // print('i am here in ib  ${weight.toString()}');
                                  }
                                  if (heightValue == 'cm') {
                                    height = convertToM(_heighController.text);
                                    // print('i am here in cm${height.toString()}');
                                  }
                                  if (weightValue == 'Kg') {
                                    weight =
                                        double.parse(_weightController.text);
                                    // print(' i am here in kg  $weight');
                                  }
                                  setState(() {});
                                  bmiCal = weight / height;
                                }

                                if (gender.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Select your gender please ',
                                      backgroundColor: Colors.deepOrange,
                                      textColor: Colors.white);
                                  return;
                                }
                                if (kDebugMode) {
                                  print('gender $gender');
                                }
                                if (!_form.currentState!.validate()) {
                                } else {
                                  Navigator.of(context).pushNamed(
                                      Result.routName,
                                      arguments: bmiCal);
                                  _ageController.text = '';
                                  _weightController.text = '';
                                  _heighController.text = '';
                                  _footController.text = '';
                                  _inchesController.text = '';
                                }
                              },
                              child: const Text(
                                'Calculate',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 20),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.grey,
                                  primary: Colors.white,
                                  padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      left: 10,
                                      right: 10)),
                              onPressed: () {
                                _heighController.text = '';
                                _ageController.text = '';
                                _weightController.text = '';
                                _footController.text = '';
                                _inchesController.text = '';
                              },
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),

                      // if (isAdBannerReady)
                      //   Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //       decoration: const BoxDecoration(),
                      //       height: _bannerAd.size.height.toDouble(),
                      //       child: AdWidget(ad: _bannerAd),
                      //     ),
                      //   )

                      // Text('${bmiCal.toStringAsPrecision(2)} kg/m2')
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  double convertIbToKg(value) {
    double result = double.parse(value) * 0.45359237;
    // print('ib to kg ${double.parse(result.toStringAsFixed(4))}');
    return double.parse(result.toStringAsFixed(4));
  }

  // 100cm=1m
//i am converting here the height
  double convertToMeter(feet, inches) {
    double m = feet * 0.3048 + feet * 0.0254;
    var precisedM = double.parse(m.toStringAsFixed(2));
    // print('meter ${precisedM * precisedM}');

    return precisedM * precisedM;
  }

  double convertToM(valueInCm) {
    double m = double.parse(valueInCm) / 100;
    // print(m);
    return m * m;
  }
}
