import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/pferd.dart';
import 'package:piflutter/pferde/pferd_detail.dart';
import 'package:piflutter/service/service.dart';

class Pferdeliste extends StatefulWidget {
  @override
  _PferdelisteState createState() => _PferdelisteState();
}

class _PferdelisteState extends State<Pferdeliste> {
  Service service = Service.getInstance();
  refresh() {
    setState(() {
      _getData = service.getPferde();
    });
  }

  late Future _getData;
  @override
  void initState() {
    _getData = service.getPferde();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Neues Pferd hinzufügen',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (context) => PferdDetail(Pferd(name: ''), refresh),
              ));
        },
      ),
      appBar: AppBar(
        title: Text('Pferde'),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Lade Pferde'),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        service.deletePferd(snapshot.data[index]).then((value) {
                          setState(() {
                            _getData = service.getPferde();
                          });
                        });
                      }),
                  title: Text(snapshot.data[index].name +
                      ' ' +
                      ((snapshot.data[index].besitzer as String).isNotEmpty
                          ? '[${snapshot.data[index].besitzer}]'
                          : '')),
                  subtitle: Text((snapshot.data[index].rfid ?? '') +
                      ' ' +
                      (snapshot.data[index].rfid_2 ?? '')),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<bool>(
                          builder: (context) =>
                              PferdDetail(snapshot.data[index], refresh),
                        ));
                  },
                );
              });
        },
        future: _getData,
      ),
    );
  }
}
