import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_sms/simple_sms.dart';

void main() => runApp(SimpleSmsExampleApp());

class SimpleSmsExampleApp extends StatefulWidget {
  @override
  _SimpleSmsExampleAppState createState() => _SimpleSmsExampleAppState();
}

class _SimpleSmsExampleAppState extends State<SimpleSmsExampleApp> {
  final contactTextFieldController = TextEditingController();
  final smsTextFieldController = TextEditingController();
  final List<String> contacts = [];
  final RegExp exp = RegExp(r'([(+]*[0-9]+[()+. -]*)');
  static const double defaultPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple sms example app'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              decoration:
                              InputDecoration(hintText: '+420123456789'),
                              controller: contactTextFieldController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: RaisedButton(
                              onPressed: () {
                                if (_validateContact( //whole this onPressed is terrible :/ didnt figure out how to display Snackbar outside of Build method
                                    contactTextFieldController.text)) {
                                  _addContact(contactTextFieldController.text);
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Contact added'),));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Contact contains invalid characters'),
                                  ));
                                }
                              },
                              child: Text('add contact'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              controller: smsTextFieldController,
                              decoration: InputDecoration(hintText: 'SMS body'),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: RaisedButton(
                              onPressed: () {
                                _sendSms(contacts, smsTextFieldController.text);
                              },
                              child: Text('Send SMS'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _addContact(String contact) {
    contacts.add(contact);
    contactTextFieldController.text = '';
  }

  bool _validateContact(String contact) {
    if (exp.firstMatch(contact) == null) {
      return false;
    } else {
      return true;
    }
  }

  _sendSms(List<String> contacts, String smsBody) async {
    final SimpleSms simpleSms = SimpleSms();
    simpleSms.sendSms(contacts, smsBody);
  }
}
