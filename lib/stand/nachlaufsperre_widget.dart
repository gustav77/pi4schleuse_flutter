import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/models/value_objects/tuer.dart';
import 'package:piflutter/service/service.dart';

import '../main.dart';

class NachlaufsperreWidget extends StatelessWidget {
  final Rfidstand stand;
  NachlaufsperreWidget(this.stand);
  final Service service = Service.getInstance();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    var timeToClose;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Nachlaufsperre',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue:
                            stand.nachlaufsperre?.timeToClose.toString(),
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
                            labelText: 'Laufzeit in Sekunden',
                            hintText: 'Benötigte Schliess- bzw Öffnungszeit'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 100),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var nls = Nachlaufsperre(
                                  timeToClose: int.parse(timeToClose));
                              // var newstand =
                              //     stand.copyWith(nachlaufsperre: nls);
                              stand.nachlaufsperre = nls;
                              service.saveStand(stand).then((value) {
                                if (value.statusCode < 300 &&
                                    value.statusCode >= 200) {
                                  showSpeicherToast(
                                      fToast, 'Gespeichert!', false);
                                  final resp = jsonDecode(value.body);
                                  if (resp['ok'] == true) {
                                    stand.rev = resp['rev'];
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
                          },
                          child: Text('Speichern')),
                    )
                  ],
                )),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      service.openNls(stand.ip);
                    },
                    child: Text('Öffnen'),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                      onPressed: () {
                        service.closeNls(stand.ip);
                      },
                      child: Text(
                        'Schließen',
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
