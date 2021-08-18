import 'dart:async';

import 'package:flutter/services.dart';

class HeapAnalytics {
  static const MethodChannel _channel = const MethodChannel('heap_analytics');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future init({required String appId}) async {
    return await _channel
        .invokeMethod('initHeap', <String, dynamic>{'appId': appId});
  }

  static Future<bool> track(
      {required String event, Map<String, dynamic>? properties}) async {
    return await _channel.invokeMethod('track',
        <String, dynamic>{'event': event, 'properties': properties ?? {}});
  }

  // static Future<bool> identify(String id) async {
  //   return await
  // }
}
