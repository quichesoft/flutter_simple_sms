import 'dart:async';

import 'package:flutter/services.dart';


class SimpleSms {

  static const _channelName =  'plugins.simple_sms.quichesoft.com/sendSms';
  static const _methodName = 'sendSMS';

  static const MethodChannel _channel =
      const MethodChannel(_channelName);
  RegExp exp = RegExp(r'/^[0-9 ()+-]+$/');

  Future<void> sendSms(List<String> addresses, String message) async {


    if (addresses.length == 0 || addresses == null){
       throw 'Address must contain at least one item';
    }

    addresses.forEach((element){
     if (exp.firstMatch(element) == null){
       throw 'Addresses contain invalid character';
     }
    });

    await _channel.invokeMethod(_methodName, [addresses, message]);
  }


}
