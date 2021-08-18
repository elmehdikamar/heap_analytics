import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:heap_analytics/heap_analytics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    doHeapThings();
    //initPlatformState();
  }

  doHeapThings() async {
    await HeapAnalytics.init(appId: '1262340541');
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await HeapAnalytics.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                    child: Text('Track event'),
                    onPressed: () {
                      HeapAnalytics.track(event: 'test');
                    }),
                CupertinoButton(
                    child: Text('Track event w/ properties'),
                    onPressed: () {
                      HeapAnalytics.track(
                          event: 'test_properties',
                          properties: {
                            'one': 'two',
                            'three': 4,
                            'four': '123'
                          });
                    }),
                CupertinoButton(
                    child: Text('Identify'),
                    onPressed: () {
                      HeapAnalytics.identify('mehdi');
                    }),
                CupertinoButton(
                    child: Text('Set User Properties'),
                    onPressed: () {
                      HeapAnalytics.addUserProperties(properties: {
                        'username': 'mehdi',
                        'email': 'elmehdikamar@gmail.com',
                        'first_name': 'Mehdi'
                      });
                    }),
                CupertinoButton(
                    child: Text('Reset identity'),
                    onPressed: () {
                      HeapAnalytics.resetIdentity();
                    })
              ],
            ),
          )),
    );
  }
}
