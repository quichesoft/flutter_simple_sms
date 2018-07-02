import 'dart:async';

import 'package:flutter/services.dart';

class SimpleSms {
  static const _channelName = 'plugins.quichesoft.com/simpleSms';
  static const _methodName = 'sendSms';

  static const MethodChannel _channel = const MethodChannel(_channelName);
  RegExp exp = RegExp(r'/^[0-9 ()+-]+$/');

  Future<void> sendSms(List<String> addresses, String message) async {
    if (addresses.length == 0 || addresses == null) {
      throw 'Address must contain at least one item';
    }

    await _channel
        .invokeMethod(_methodName, <String, Object>{'addresses': addresses, 'message': message});
  }
}
