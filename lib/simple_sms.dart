import 'dart:async';

import 'package:flutter/services.dart';

class SimpleSms {
  static const MethodChannel _channel =
      const MethodChannel('simple_sms');

  static Future<String> get platformVersion async {
    // @TODO ENUM function names
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<void> sendSms(List<String> addresses, String message) async {
    // @TODO validation

    await _channel.invokeMethod("sendSMS");
  }
}
