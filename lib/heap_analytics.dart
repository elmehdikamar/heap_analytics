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

  static Future track(
      {required String event,
      Map<String, dynamic>? properties,
      bool keepNull = false}) async {
    var _properties = properties ?? {};
    if (!keepNull) _properties.removeWhere((key, value) => value == null);
    _properties.updateAll((key, value) => value.toString());
    return await _channel.invokeMethod(
        'track', <String, dynamic>{'event': event, 'properties': _properties});
  }

  static Future identify(String id) async {
    return await _channel.invokeMethod('identify', <String, dynamic>{'id': id});
  }

  static Future addUserProperties(
      {required Map<String, dynamic> properties, bool keepNull = false}) async {
    var _properties = properties;
    if (!keepNull) _properties.removeWhere((key, value) => value == null);
    _properties.updateAll((key, value) => value.toString());
    return await _channel.invokeMethod(
        'addUserProperties', <String, dynamic>{'properties': _properties});
  }

  static Future resetIdentity() async {
    return await _channel.invokeMethod('resetIdentity');
  }
}
