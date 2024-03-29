import 'package:flutter/material.dart';

import 'package:insider_ios/components/CustomTitle.dart';

import 'package:insider_ios/insider/Event.dart';
import 'package:insider_ios/insider/GDPR.dart';
import 'package:insider_ios/insider/MessageCenter.dart';
import 'package:insider_ios/insider/PageVisit.dart';
import 'package:insider_ios/insider/Product.dart';
import 'package:insider_ios/insider/Purchase.dart';
import 'package:insider_ios/insider/SmartRecommender.dart';
import 'package:insider_ios/insider/SocialProof.dart';
import 'package:insider_ios/insider/UserAttribute.dart';
import 'package:insider_ios/insider/UserIdentifier.dart';
import 'package:insider_ios/insider/ContentOptimizer.dart';

import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/enum/InsiderCallbackAction.dart';

Future<void> main() async {
  runApp(const InsiderDemo());
}

class InsiderDemo extends StatelessWidget {
  const InsiderDemo({Key? key}) : super(key: key);

  Future initInsider() async {
    // FIXME-INSIDER: Please change with your partner name and app group.
    await FlutterInsider.Instance.init(
        "keretaapiindonesiauat", "group.com.useinsider.FlutterDemo",
        (int type, dynamic data) {
      switch (type) {
        case InsiderCallbackAction.NOTIFICATION_OPEN:
          print('[INSIDER][NOTIFICATION_OPEN]: $data');
          break;
        case InsiderCallbackAction.TEMP_STORE_CUSTOM_ACTION:
          print('[INSIDER][TEMP_STORE_CUSTOM_ACTION]: $data');
          break;
        default:
          print("[INSIDER][InsiderCallbackAction]: Unregistered Action!");
          break;
      }
    });

    // This is an utility method, if you want to handle the push permission in iOS own your own you can omit the following method.
    FlutterInsider.Instance.setActiveForegroundPushView();
    FlutterInsider.Instance.registerWithQuietPermission(false);
    FlutterInsider.Instance.enableIDFACollection(true);
    FlutterInsider.Instance.enableIpCollection(true);
    FlutterInsider.Instance.enableCarrierCollection(true);
    FlutterInsider.Instance.enableLocationCollection(true);
    FlutterInsider.Instance.startTrackingGeofence();
  }

  @override
  Widget build(BuildContext context) {
    initInsider();

    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(title: '[Flutter] Insider SDK Demo'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      Text(
                        '[Flutter] Insider SDK Demo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'This Demo contains simple methods that you can use with the Insider SDK.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                CustomTitle(title: 'User Attributes'),
                UserAttribute(),
                CustomTitle(title: 'User Identifiers'),
                UserIdentifier(),
                CustomTitle(title: 'Event'),
                Event(),
                CustomTitle(title: 'Product'),
                Product(),
                CustomTitle(title: 'Purchase'),
                Purchase(),
                CustomTitle(title: 'Smart Recommender'),
                SmartRecommender(),
                CustomTitle(title: 'Social Proof'),
                SocialProof(),
                CustomTitle(title: 'Page Visit Methods'),
                PageVisit(),
                CustomTitle(title: 'GDPR'),
                GDPR(),
                CustomTitle(title: 'Message Center'),
                MessageCenter(),
                CustomTitle(title: 'Content Optimizer'),
                ContentOptimizer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
