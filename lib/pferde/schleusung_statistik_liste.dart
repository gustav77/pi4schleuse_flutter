import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/pferd.dart';
import 'package:piflutter/service/service.dart';

class SchleusungStatistikListe extends StatefulWidget {
  final Pferd pferd;
  SchleusungStatistikListe({required this.pferd});
  @override
  _SchleusungStatistikListeState createState() =>
      _SchleusungStatistikListeState();
}

class _SchleusungStatistikListeState extends State<SchleusungStatistikListe> {
  Service service = Service.getInstance();
  late Future _getData;

  @override
  void initState() {
    _getData = service.getSchleusungen(pferdid: widget.pferd.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pferd.name),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Lade Schleusungen'),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].time +
                      ' ' +
                      ((snapshot.data[index].tuer as String).isNotEmpty
                          ? '${snapshot.data[index].tuer} ${snapshot.data[index].richtung}'
                          : '')),
                  //subtitle: Text((snapshot.data[index].rfid ?? '') + ' '),
                );
              });
        },
        future: _getData,
      ),
    );
  }
}
