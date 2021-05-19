import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piflutter/models/entities/pferd.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/models/value_objects/dosierung.dart';
import 'package:piflutter/models/value_objects/intervall.dart';
import 'package:piflutter/models/value_objects/tuer.dart';
import 'package:piflutter/pferde/fuetterung_statistik_liste.dart';
import 'package:piflutter/pferde/schleusung_statistik_liste.dart';
import 'package:piflutter/service/service.dart';

import '../main.dart';

class PferdDetail extends StatefulWidget {
  final Pferd pferd;
  final Function refreshCallback;
  PferdDetail(this.pferd, this.refreshCallback);
  @override
  _PferdDetailState createState() => _PferdDetailState();
}

class _PferdDetailState extends State<PferdDetail> {
  Service service = Service.getInstance();
  final _formKey = GlobalKey<FormState>();
  late Pferd horse;
  var rfid_1Ctrl;
  var rfid_2Ctrl;

  late FToast fToast;
  @override
  void initState() {
    horse = widget.pferd.copyWith();
    rfid_1Ctrl = TextEditingController(text: horse.rfid);
    rfid_2Ctrl = TextEditingController(text: horse.rfid_2);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  GlobalKey<FormState> _futterschieberFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _schleusenZutrittFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _rationFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if ((horse.rfid == null || horse.rfid!.isEmpty) &&
                  (horse.rfid_2 == null || horse.rfid_2!.isEmpty)) {
                service.savePferd(horse).then((value) {
                  widget.refreshCallback();
                  showSpeicherToast(fToast, 'Gespeichert!', false);
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  showSpeicherToast(fToast, 'Fehler aufgetreten!', true);
                });
              } else {
                rfidSchonVergeben(horse).then((value) {
                  if (value) {
                  } else {
                    service.savePferd(horse).then((value) {
                      widget.refreshCallback();
                      Navigator.pop(context);
                    });
                  }
                });
              }
            }
          }),
      appBar: AppBar(
        title: Text(widget.pferd.name),
      ),
      body: FutureBuilder(
        future: service.findstaende(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Lade die Konfiguration'),
            );
          }

          return Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onSaved: (String? value) {
                              horse = horse.copyWith(name: value);
                            },
                            initialValue: horse.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Ein Name muss angegeben werden.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Der Name des Pferdes'),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            onSaved: (String? value) {
                              horse = horse.copyWith(besitzer: value);
                            },
                            initialValue: horse.besitzer,
                            decoration: InputDecoration(
                                labelText: 'Besitzer',
                                hintText: 'Der Besitzer des Pferdes'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: rfid_1Ctrl,
                            onSaved: (String? value) {
                              if (value == 'Keine ID gelesen') {
                                horse = horse.copyWith(rfid: '');
                              } else {
                                horse = horse.copyWith(rfid: value);
                              }
                            },
                            decoration: InputDecoration(labelText: '1. Chip'),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('1. Chip einlesen'),
                            onPressed: () {
                              service.getRfid().then((value) {
                                setState(() {
                                  rfid_1Ctrl.text = value;
                                });
                              }).onError((error, stackTrace) {
                                //print('CORS Fehler');
                                //horse.rfid = 'konnte nicht gelesen werden';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: rfid_2Ctrl,
                            onSaved: (String? value) {
                              if (value == 'Keine ID gelesen') {
                                horse = horse.copyWith(rfid_2: '');
                              } else {
                                horse = horse.copyWith(rfid_2: value);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: '2. Chip (optional)',
                                hintText:
                                    'Nur wenn an den Halsbändern auch zwei Chips angebracht sind'),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('2. Chip einlesen'),
                            onPressed: () {
                              service.getRfid().then((value) {
                                setState(() {
                                  rfid_2Ctrl.text = value;
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (has(staende: snapshot.data, typ: 'futterschieber'))
                      Divider(),
                    if (has(staende: snapshot.data, typ: 'futterschieber'))
                      ElevatedButton(
                          onPressed: () async {
                            var fb = await createFutterschieberDialog(context);

                            if (fb != null) {
                              setState(() {
                                if (horse.futterschieber == null) {
                                  horse.futterschieber = [];
                                }
                                horse.futterschieber!.add(fb);
                                service.savePferd(horse).then((value) async {
                                  widget.refreshCallback();
                                  horse = await service.getPferd(horse.id!);
                                });
                              });
                            }
                          },
                          child: Text('Futterschieberberechtigung hinzufügen')),
                    if (has(staende: snapshot.data, typ: 'futterschieber'))
                      Expanded(
                        child: ListView.builder(
                            itemCount: horse.futterschieber != null
                                ? horse.futterschieber!.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        horse.futterschieber!.removeAt(index);
                                        service
                                            .savePferd(horse)
                                            .then((value) async {
                                          widget.refreshCallback();
                                          horse =
                                              await service.getPferd(horse.id!);
                                        });
                                      });
                                    }),
                                title: Text(horse.futterschieber![index].von +
                                    ' - ' +
                                    horse.futterschieber![index].bis +
                                    '  ' +
                                    horse.futterschieber![index]
                                        .openTimeWithoutRfidReading
                                        .toString() +
                                    ' Sekunden'),
                                subtitle: Text(horse
                                        .futterschieber![index].standname +
                                    ' / ' +
                                    horse.futterschieber![index].schiebername),
                              );
                            }),
                      ),
                    if (has(staende: snapshot.data, typ: 'tueren')) Divider(),
                    if (has(staende: snapshot.data, typ: 'tueren'))
                      ElevatedButton(
                          onPressed: () async {
                            var fb = await createSchleusenZutrittDialog(
                                context, snapshot.data);

                            if (fb != null) {
                              setState(() {
                                if (horse.intervalle == null) {
                                  horse.intervalle = [];
                                }
                                horse.intervalle!.add(fb);
                              });
                              _formKey.currentState!.save();
                              service.savePferd(horse).then((value) async {
                                widget.refreshCallback();
                                horse = await service.getPferd(horse.id!);
                              });
                            }
                          },
                          child: Text('Zutrittsberechtigung hinzufügen')),
                    if (has(staende: snapshot.data, typ: 'tueren'))
                      Expanded(
                        child: ListView.builder(
                            itemCount: horse.intervalle != null
                                ? horse.intervalle!.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        horse.intervalle!.removeAt(index);
                                        service
                                            .savePferd(horse)
                                            .then((value) async {
                                          widget.refreshCallback();
                                          horse =
                                              await service.getPferd(horse.id!);
                                        });
                                      });
                                    }),
                                title: Text(horse.intervalle![index].von +
                                    ' - ' +
                                    horse.intervalle![index].bis),
                                subtitle: Text(
                                    horse.intervalle![index].standname +
                                        ' / ' +
                                        horse.intervalle![index].tuername),
                              );
                            }),
                      ),
                    if (has(staende: snapshot.data, typ: 'dosierer')) Divider(),
                    if (has(staende: snapshot.data, typ: 'dosierer'))
                      ElevatedButton(
                          onPressed: () async {
                            var fb = await createDosierungDialog(
                                context, futtermittel(staende: snapshot.data));

                            if (fb != null) {
                              setState(() {
                                if (horse.rationen == null) {
                                  horse.rationen = [];
                                }
                                horse.rationen!.add(fb);
                                //Speichern ohne die Seite zu verlassen
                                service.savePferd(horse).then((value) async {
                                  widget.refreshCallback();
                                  horse = await service.getPferd(horse.id!);
                                });
                              });
                            }
                          },
                          child: Text('Futterration hinzufügen')),
                    if (has(staende: snapshot.data, typ: 'dosierer'))
                      Expanded(
                        child: ListView.builder(
                            itemCount: horse.rationen != null
                                ? horse.rationen!.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        horse.rationen!.removeAt(index);
                                        service
                                            .savePferd(horse)
                                            .then((value) async {
                                          widget.refreshCallback();
                                          horse =
                                              await service.getPferd(horse.id!);
                                        });
                                      });
                                    }),
                                title: Text(horse.rationen![index].futtername +
                                    ' ' +
                                    horse.rationen![index].portion.toString() +
                                    'g, Pause ' +
                                    horse.rationen![index].pause.toString() +
                                    ' Min.'),
                                subtitle: Text(horse.rationen![index].tageslimit
                                        .toString() +
                                    'g, ' +
                                    'Fresszeit ' +
                                    ((horse.rationen![index].fresszeit != null)
                                        ? horse.rationen![index].fresszeit
                                                .toString() +
                                            ' Min.'
                                        : ' 1 Min./100g')),
                              );
                            }),
                      ),
                    Row(
                      children: [
                        if (has(staende: snapshot.data, typ: 'dosierer'))
                          TextButton(
                            child: Text('Fütterungen'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (context) =>
                                        FuetterungStatistikListe(
                                      pferd: widget.pferd,
                                    ),
                                  ));
                            },
                          ),
                        SizedBox(
                          width: 15,
                        ),
                        if (has(staende: snapshot.data, typ: 'tueren'))
                          TextButton(
                            child: Text('Schleusungen'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (context) =>
                                        SchleusungStatistikListe(
                                      pferd: widget.pferd,
                                    ),
                                  ));
                            },
                          ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  List<String> futtermittel({required List<Rfidstand> staende}) {
    List<String> futtermittel = [];
    for (var stand in staende) {
      if (stand.dosierer != null && stand.dosierer!.isNotEmpty) {
        for (var dos in stand.dosierer!) {
          if (!futtermittel.contains(dos.futtername)) {
            futtermittel.add(dos.futtername);
          }
        }
      }
    }
    return futtermittel;
  }

  bool has({required List<Rfidstand> staende, required String typ}) {
    if (typ == 'dosierer') {
      for (var stand in staende) {
        if (stand.dosierer != null && stand.dosierer!.isNotEmpty) {
          return true;
        }
      }
    }
    if (typ == 'tueren') {
      for (var stand in staende) {
        if (stand.tueren != null && stand.tueren!.isNotEmpty) {
          return true;
        }
      }
    }
    if (typ == 'futterschieber') {
      for (var stand in staende) {
        if (stand.futterschieber != null && stand.futterschieber!.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> rfidSchonVergeben(Pferd horse) async {
    var result =
        await service.getPferdWithRfid(horse.rfid!).then((value) async {
      if (value != null && value.id != horse.id) {
        showSpeicherToast(fToast,
            '1. Chip-Nummer ist schon vergeben für ${value.name}', true);
        return true;
      } else {
        var result2 =
            await service.getPferdWithRfid(horse.rfid_2!).then((value) {
          if (value != null && value.id != horse.id) {
            showSpeicherToast(fToast,
                '2. Chip-Nummer ist schon vergeben für ${value.name}', true);
            return true;
          } else {
            return false;
          }
        });
        return result2;
      }
    });
    return result;
  }

  Future<Dosierung>? createDosierungDialog(
      BuildContext context, List<String> futtermittel) async {
    List<DropdownMenuItem<String>> futterliste = futtermittel
        .map((e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ))
        .toList();

    return await showDialog(
        context: context,
        builder: (builder) {
          var futter;
          var tageslimit;
          var portion;
          var pause;
          var intervalldosierung = false;
          var fresszeit;
          var teilportion;
          var teilpause;
          return AlertDialog(
            title: Text('Futterration'),
            content: Form(
              key: _rationFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    hint: Text('Futter'),
                    onChanged: (value) {
                      futter = value;
                    },
                    items: futterliste,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      tageslimit = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Der Tagesbedarf ist erforderlich';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Ungültige Eingabe';
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: 'Tagesbedarf in Gramm'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      portion = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Die Portionsangabe ist erforderlich';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Ungültige Eingabe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Portion in Gramm'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      pause = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Die Pausenangabe ist erforderlich';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Ungültige Eingabe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Fresspause in Minuten',
                        hintText: 'Pause zwischen Fütterungen in Minuten'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      fresszeit = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (int.tryParse(value) == null) {
                        return 'Ungültige Eingabe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Fresszeit in Minuten',
                        hintText: 'Schliessdauer der Nachlaufsperre'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_rationFormKey.currentState!.validate()) {
                      _rationFormKey.currentState!.save();
                      var fb = Dosierung(
                        futtername: futter,
                        intervalldosierung: intervalldosierung,
                        pause: int.parse(pause),
                        portion: int.parse(portion),
                        tageslimit: int.parse(tageslimit),
                        fresszeit: int.parse(fresszeit),
                      );
                      Navigator.of(context).pop(fb);
                    }
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  Future<FutterschieberInterval>? createFutterschieberDialog(
      BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var von;
          var bis;
          var opentime;
          return AlertDialog(
            title: Text('Neue Futterschieberberechtigung'),
            content: Form(
              key: _futterschieberFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onSaved: (value) {
                      von = value;
                    },
                    validator: (value) {
                      return checkUhrzeit(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'Start Uhrzeit', hintText: 'hh:mm'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      bis = value;
                    },
                    validator: (value) {
                      return checkUhrzeit(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'Ende Uhrzeit', hintText: 'hh:mm'),
                  ),
                  TextFormField(
                    onSaved: (value) {
                      opentime = value;
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Die Zeit muss angegeben werden.';
                      }
                      if (value != null) {
                        var i = int.tryParse(value);
                        if (i == null || i < 0) {
                          return 'Die Öffnungszeit muss angegeben werden';
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Öffnungszeit',
                        hintText:
                            'Zeit in Sekunden nach der letzten Erkennung'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_futterschieberFormKey.currentState!.validate()) {
                      _futterschieberFormKey.currentState!.save();
                      var fb = FutterschieberInterval(
                          bis: bis,
                          openTimeWithoutRfidReading: int.parse(opentime),
                          schiebername: 'Schieber',
                          standname: 'Stand1',
                          von: von);
                      Navigator.of(context).pop(fb);
                    }
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  checkUhrzeit(value) {
    if (value != null && value.isEmpty) {
      return 'Die Zeit muss angegeben werden.';
    }
    if (value != null && value.isNotEmpty) {
      if (value.length != 5) {
        return 'Das Format muss benutzt werden: hh:mm';
      }
      if (value.substring(2, 3) != ':') {
        return 'Das Format muss benutzt werden: hh:mm';
      }
      var std = int.tryParse(value.substring(0, 2));
      if (std == null || std > 23 || std < 0) {
        return 'Ungültige Zeitangabe';
      }
      var min = int.tryParse(value.substring(3, 5));
      if (min == null || min > 59 || min < 0) {
        return 'Ungültige Zeitangabe';
      }
    }
    return null;
  }

  Future<SchleusenInterval>? createSchleusenZutrittDialog(
      BuildContext context, List<Rfidstand> staende) async {
    List<Tuer> doors = [];
    for (final stand in staende) {
      if (stand.tueren != null) {
        for (final t in stand.tueren!) {
          doors.add(t.copyWith(standname: stand.name));
        }
      }
    }
    List<DropdownMenuItem<Tuer>> doorchoice = [];
    for (final d in doors) {
      doorchoice.add(DropdownMenuItem<Tuer>(
        child: Text('${d.standname}: ${d.name}'),
        value: d,
      ));
    }
    return await showDialog(
        context: context,
        builder: (context) {
          var von;
          var bis;
          Tuer? _selectedTuer;

          return AlertDialog(
            title: Text('Neue Zutrittsberechtigung'),
            content: Form(
              key: _schleusenZutrittFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (doors.length > 1)
                    DropdownButtonFormField<Tuer>(
                        hint: Text('Tür'),
                        value: _selectedTuer,
                        onChanged: (value) {
                          setState(() {
                            _selectedTuer = value;
                          });
                        },
                        items: doorchoice)
                  else
                    Container(),
                  TextFormField(
                    onSaved: (value) {
                      von = value;
                    },
                    validator: (value) {
                      return checkUhrzeit(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'Start Uhrzeit', hintText: 'hh:mm'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      bis = value;
                    },
                    validator: (value) {
                      return checkUhrzeit(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'Ende Uhrzeit', hintText: 'hh:mm'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_schleusenZutrittFormKey.currentState!.validate()) {
                      _schleusenZutrittFormKey.currentState!.save();
                      var fb = SchleusenInterval(
                          bis: bis,
                          tuername: _selectedTuer?.name ?? doors[0].name,
                          standname:
                              _selectedTuer?.standname ?? doors[0].standname!,
                          von: von);
                      Navigator.of(context).pop(fb);
                    }
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}
