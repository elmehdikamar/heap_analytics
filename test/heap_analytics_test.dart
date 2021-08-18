import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heap_analytics/heap_analytics.dart';

void main() {
  const MethodChannel channel = MethodChannel('heap_analytics');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await HeapAnalytics.platformVersion, '42');
  });
}
