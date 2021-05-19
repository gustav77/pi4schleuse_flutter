import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/models/value_objects/tuer.dart';
import 'package:piflutter/service/service.dart';

import '../main.dart';

class TuerWidget extends StatefulWidget {
  final Rfidstand stand;
  TuerWidget(this.stand);

  @override
  _TuerWidgetState createState() => _TuerWidgetState();
}

class _TuerWidgetState extends State<TuerWidget> {
  final Service service = Service.getInstance();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FToast fToast = FToast();
  Tuer? _selectedTuer;
  final timeToCloseCtrl = TextEditingController();
  final openTimeCtrl = TextEditingController();
  @override
  void initState() {
    if (widget.stand.tueren!.length == 1) {
      _selectedTuer = widget.stand.tueren![0];

      timeToCloseCtrl.text = _selectedTuer!.timeToClose.toString();
      openTimeCtrl.text = _selectedTuer!.openTime.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    var timeToClose;
    var openTime;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Schleusentür',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            if (widget.stand.tueren!.length > 1)
              DropdownButtonFormField<String>(
                hint: Text('Tür'),
                // value: 'Tür 1',
                onChanged: (value) {
                  setState(() {
                    _selectedTuer = widget.stand.tueren!
                        .firstWhere((element) => element.name == value);

                    timeToCloseCtrl.text =
                        _selectedTuer!.timeToClose.toString();
                    openTimeCtrl.text = _selectedTuer!.openTime.toString();
                  });
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('Tür 1'),
                    value: 'Tür 1',
                  ),
                  DropdownMenuItem(
                    child: Text('Tür 2'),
                    value: 'Tür 2',
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
                      controller: timeToCloseCtrl,
                      keyboardType: TextInputType.number,
                      //initialValue: _selectedTuer.timeToClose.toString(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Die Zeit muss angegeben werden.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ungültige Eingabe';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        timeToClose = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Schliess- bzw Öffnungszeit in Sekunden'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextFormField(
                      controller: openTimeCtrl,
                      keyboardType: TextInputType.number,
                      //initialValue: _selectedTuer.timeToClose.toString(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Die Zeit muss angegeben werden.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ungültige Eingabe';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        openTime = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Wartezeit vor dem Schliessen in Sekunden',
                          hintText: 'Zeit bevor die Tür wieder schliesst'),
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
                    onPressed: _selectedTuer != null
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              //widget.stand.tueren!.remove(_selectedTuer);
                              // var newDoor = _selectedTuer!.copyWith(
                              //     timeToClose: int.parse(timeToClose),
                              //     openTime: int.parse(openTime));
                              // var newStand = widget.stand.copyWith();
                              _selectedTuer!.timeToClose =
                                  int.parse(timeToClose);
                              _selectedTuer!.openTime = int.parse(openTime);
                              //newStand.tueren!.add(newDoor);
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
                    onPressed: _selectedTuer != null
                        ? () {
                            service.openDoor(
                                widget.stand.ip, _selectedTuer!.name);
                          }
                        : null,
                    child: Text('Öffnen'),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                      onPressed: _selectedTuer != null
                          ? () {
                              service.closeDoor(
                                  widget.stand.ip, _selectedTuer!.name);
                            }
                          : null,
                      child: Text(
                        'Schliessen',
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
