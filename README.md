# Simple sms

Plugin for simple sending sms. We have developed this one, because we needed plugin that supports 
multiple recipients. 

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/platform-plugins/#edit-code).


## Installation and Usage


add `simple_sms` to your `pubspec.yaml` 

```
dependencies:
  flutter:
      sdk: flutter
  simple_sms:
```

then run `flutter packages get`


## Sending sms


create instance of `SimpleSms`

```
final SimpleSms simpleSms = SimpleSms();
```

and then supply `List<String> contacts` and `String smsBody` to it's `sendSms()` function

```
simpleSms.sendSms(contacts, smsBody);
```