import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/pferd.dart';
import 'package:piflutter/service/service.dart';

class FuetterungStatistikListe extends StatefulWidget {
  final Pferd pferd;
  FuetterungStatistikListe({required this.pferd});
  @override
  _FuetterungStatistikListeState createState() =>
      _FuetterungStatistikListeState();
}

class _FuetterungStatistikListeState extends State<FuetterungStatistikListe> {
  Service service = Service.getInstance();
  late Future _getData;

  @override
  void initState() {
    _getData = service.getFuetterungen(pferdid: widget.pferd.id!);
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
                child: Text('Lade Fütterungen'),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].time +
                      ' ' +
                      ((snapshot.data[index].futtername as String).isNotEmpty
                          ? '${snapshot.data[index].futtername} ${snapshot.data[index].menge}g'
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
