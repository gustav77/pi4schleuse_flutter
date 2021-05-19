import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/models/value_objects/dosierer.dart';
import 'package:piflutter/service/service.dart';

import '../main.dart';

class DosiererWidget extends StatefulWidget {
  final Rfidstand stand;
  DosiererWidget(this.stand);

  @override
  _DosiererWidgetState createState() => _DosiererWidgetState();
}

class _DosiererWidgetState extends State<DosiererWidget> {
  final Service service = Service.getInstance();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FToast fToast = FToast();
  Dosierer? _selectedDosierer;
  final grammPerTenSecondsCtrl = TextEditingController();
  final futterCtrl = TextEditingController();
  @override
  void initState() {
    if (widget.stand.dosierer!.length == 1) {
      _selectedDosierer = widget.stand.dosierer![0];
      futterCtrl.text = _selectedDosierer!.futtername;
      grammPerTenSecondsCtrl.text =
          _selectedDosierer!.grammPerTenSeconds.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    var grammPerTenSeconds;
    var futter;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Dosierer',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            if (widget.stand.dosierer!.length > 1)
              DropdownButtonFormField<String>(
                hint: Text('Dosierer'),
                onChanged: (value) {
                  setState(() {
                    _selectedDosierer = widget.stand.dosierer!
                        .firstWhere((element) => element.name == value);
                    futterCtrl.text = _selectedDosierer!.futtername;
                    grammPerTenSecondsCtrl.text =
                        _selectedDosierer!.grammPerTenSeconds.toString();
                  });
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('Dosierer 1'),
                    value: 'Dosierer 1',
                  ),
                  DropdownMenuItem(
                    child: Text('Dosierer 2'),
                    value: 'Dosierer 2',
                  ),
                ],
              )
            else
              Container(),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: futterCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Das Futter muss angegeben werden.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        futter = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Futter im Dosierer'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextFormField(
                      controller: grammPerTenSecondsCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Die Angabe ist erforderlich.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ungültige Eingabe';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        grammPerTenSeconds = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Fördermenge in 10 Sekunden',
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _selectedDosierer != null
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _selectedDosierer!.futtername = futter;
                              _selectedDosierer!.grammPerTenSeconds =
                                  int.parse(grammPerTenSeconds);
                              service.saveStand(widget.stand).then((value) {
                                if (value.statusCode < 300 &&
                                    value.statusCode >= 200) {
                                  showSpeicherToast(
                                      fToast, 'Gespeichert!', false);
                                  final resp = jsonDecode(value.body);
                                  if (resp['ok'] == true) {
                                    widget.stand.rev = resp['rev'];
                                  }
                                } else {
                                  showSpeicherToast(
                                      fToast, 'Fehler aufgetreten!', true);
                                }
                              }).onError((error, stackTrace) {
                                showSpeicherToast(
                                    fToast, 'Fehler aufgetreten!', true);
                              });
                            }
                          }
                        : null,
                    child: Text('Speichern')),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                    onPressed: _selectedDosierer != null
                        ? () {
                            service.startDosierer(
                                widget.stand.ip, _selectedDosierer!.name);
                          }
                        : null,
                    child: Text('Starten'),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                      onPressed: _selectedDosierer != null
                          ? () {
                              service.stopDosierer(
                                  widget.stand.ip, _selectedDosierer!.name);
                            }
                          : null,
                      child: Text(
                        'Stoppen',
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
