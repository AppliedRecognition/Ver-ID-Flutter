import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:developer' as developer;
import 'package:veridflutterplugin/veridflutterplugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('veridflutterplugin');
  const String USER_ID = 'TESTING_USER_ID';

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('defineAutoTests', () {
    test(
        'test that method channel is defined (we do not have reflection in Flutter yet, so we will add method introspection once this changes',
        () {
      expect(null != channel, true);
    });
  });

  group('Ver Id plugin, testing of load and unload functions', () {
    test('Testing load', () async {
      final String result = await channel.invokeMethod('load');
      expect(result == "Exception in load.", false);
    });

    test('Testing unload', () async {
      final String unloadResult = await channel.invokeMethod('unload');
      developer.log("unloadResult: " + unloadResult);
      expect(unloadResult.isEmpty, true);
    });
  });
}
