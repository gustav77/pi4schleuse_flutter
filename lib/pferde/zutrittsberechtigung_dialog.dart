import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/models/value_objects/intervall.dart';
import 'package:piflutter/models/value_objects/tuer.dart';

class ZutrittsberechtigungDialog extends StatefulWidget {
  const ZutrittsberechtigungDialog(
      {Key? key, required this.staende, required this.fullduplex})
      : super(key: key);
  //final List<Tuer> doors;
  final List<Rfidstand> staende;
  final bool fullduplex;
  @override
  _ZutrittsberechtigungDialogState createState() =>
      _ZutrittsberechtigungDialogState();
}

class _ZutrittsberechtigungDialogState
    extends State<ZutrittsberechtigungDialog> {
  GlobalKey<FormState> _schleusenZutrittFormKey = GlobalKey<FormState>();

  Tuer? _selectedTuer;
  List<DropdownMenuItem<Tuer>> doorchoice = [];
  List<Tuer> doors = [];
  var von;
  var bis;
  var reinChecked = true;
  var rausChecked = false;

  @override
  void initState() {
    super.initState();

    for (final stand in widget.staende) {
      if (stand.tueren != null) {
        for (final t in stand.tueren!) {
          doors.add(t.copyWith(standname: stand.name));
        }
      }
    }
    for (final d in doors) {
      doorchoice.add(DropdownMenuItem<Tuer>(
        child: Text('${d.standname}: ${d.name}'),
        value: d,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Neue Zutrittsberechtigung'),
      content: Form(
        key: _schleusenZutrittFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (doorchoice.length > 1)
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
              decoration:
                  InputDecoration(labelText: 'Ende Uhrzeit', hintText: 'hh:mm'),
            ),
            SizedBox(
              height: 15.0,
            ),
            if (widget.fullduplex)
              CheckboxListTile(
                  tristate: false,
                  title: Text("Gilt für rein"),
                  value: reinChecked,
                  onChanged: (value) {
                    setState(() {
                      reinChecked = value!;
                    });
                  })
            else
              Container(),
            if (widget.fullduplex)
              CheckboxListTile(
                  tristate: false,
                  title: Text("Gilt für raus"),
                  value: rausChecked,
                  onChanged: (value) {
                    setState(() {
                      rausChecked = value!;
                    });
                  })
            else
              Container()
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
                    standname: _selectedTuer?.standname ?? doors[0].standname!,
                    von: von,
                    giltFuerRaus: rausChecked,
                    giltFuerRein: reinChecked);
                Navigator.of(context).pop(fb);
              }
            },
            child: Text('Ok')),
      ],
    );
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
}
