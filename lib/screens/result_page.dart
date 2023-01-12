import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../widgets/arrange_space.dart';
import '../widgets/resultBmi.dart';
import 'package:flutter/material.dart';
import '../widgets/progressIndicator.dart';
import '../widgets/information.dart';
import '../widgets/divider.dart';

enum Rout { details }

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);
  static const routName = 'resultPage';

  @override
  State<Result> createState() => _ResultState();
}

const int maxFailedLoadAttempts = 3;

class _ResultState extends State<Result> {
  late InterstitialAd? _interstitialAd;
  bool isinterstitialReady = false;
  int interstitialLoadAttempts = 0;

  late BannerAd _bannerAd;
  bool isAdBannerReady = false;

  @override
  void initState() {
    createInterstitialAds();
    loadAds();
    super.initState();
  }

  loadAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5769137860547781/7075601393",
        listener: BannerAdListener(
            onAdLoaded: ((ad) {
              if (kDebugMode) {
                setState(() {
                  isAdBannerReady = true;
                });
                print('Add Loaded');
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

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          createInterstitialAds();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          createInterstitialAds();
        },
      );
      _interstitialAd!.show();
    }
  }

  void createInterstitialAds() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-5769137860547781/4091889994",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (add) {
          setState(() {
            interstitialLoadAttempts = 0;
            _interstitialAd = add;
          });
        }, onAdFailedToLoad: (LoadAdError err) {
          interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (interstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAds();
          }

          if (kDebugMode) {
            print(err.toString());
          }
          createInterstitialAds();
        }));
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as double;
    if (kDebugMode) {
      print(data.toStringAsFixed(1));
    } //i just extracted my data from this shit
    var mdQ = MediaQuery.of(context).size;
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
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            actions: [
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == Rout.details) {
                      Navigator.of(context)
                          .pushNamed(InformationWidget.routName);
                    }
                  },
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: Rout.details, child: Text('Bmi Details'))
                      ])
            ],
            title: const Text(
              'Bmi Result',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
        body: !isLandScape
            ? WillPopScope(
                onWillPop: () async {
                  _showInterstitialAd();

                  return true;
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ProgressIndication(),
                      // Text(
                      //   'Your Bmi is : ${data.toStringAsFixed(2)}',
                      //   style: const TextStyle(
                      //       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                      // ),
                      Card(
                        elevation: 20,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: mdQ.height * 0.60,
                          decoration: const BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Space(
                                  heightOfWidget: 20,
                                ),
                                if (data < 16.0)
                                  BmiResult(
                                      data: data,
                                      weightType: 'Very Severly UnderWeight'),
                                if (data > 16.0 && data < 18.5)
                                  BmiResult(
                                      data: data,
                                      weightType: 'UnderWeighet',
                                      color: Colors.red),
                                if (data > 18.5 && data < 25.0)
                                  BmiResult(data: data, weightType: 'Normal'),
                                if (data > 25.0 && data < 40.0)
                                  BmiResult(
                                      data: data, weightType: 'OverWeight'),
                                if (data > 40.0)
                                  BmiResult(
                                      data: data,
                                      weightType: 'Severly OverWeight'),
                                const Space(heightOfWidget: 8),
                                const DivideWidget(),
                                const Space(
                                  heightOfWidget: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Information',
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Space(
                                  heightOfWidget: 30,
                                ),
                                const ProgressIndication(),
                                const Space(
                                  heightOfWidget: 50,
                                ),
                                button(context)
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
              )
            : Card(
                child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        const Space(
                          heightOfWidget: 50,
                        ),
                        if (data < 16.0)
                          BmiResult(
                              data: data,
                              weightType: 'Very Severly UnderWeight'),
                        if (data > 16.0 && data < 18.5)
                          BmiResult(
                              data: data,
                              weightType: 'UnderWeighet',
                              color: Colors.red),
                        if (data > 18.5 && data < 25.0)
                          BmiResult(data: data, weightType: 'Normal'),
                        if (data > 25.0 && data < 40.0)
                          BmiResult(data: data, weightType: 'OverWeight'),
                        if (data > 40.0)
                          BmiResult(
                              data: data, weightType: 'Severly OverWeight'),
                        const Space(heightOfWidget: 8),
                        const DivideWidget(),
                        const Spacer(flex: 4),
                        button(context)
                      ],
                    )),
              ));
  }

  Widget button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showInterstitialAd();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 70)),
      child: const Text(
        'Recalculate',
        style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    );
  }
}
