import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/service/service.dart';
import 'package:piflutter/stand/futterschieber_widget.dart';
import 'package:piflutter/stand/nachlaufsperre_widget.dart';
import 'package:piflutter/stand/tuer_widget.dart';

import 'dosierer_widget.dart';

class StandDetail extends StatefulWidget {
  final Rfidstand stand;
  StandDetail(this.stand);
  @override
  _State createState() => _State();
}

class _State extends State<StandDetail> {
  Service service = Service.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.stand.name),
        ),
        body: FutureBuilder(
          future: service.getKonfiguration(widget.stand.ip),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('${widget.stand.name} ist offline!'),
                ),
              );
            }
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Lade die Konfiguration'),
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (snapshot.data as RfidstandKonfiguration)
                              .hatFutterschieber
                          ? FutterschieberWidget(widget.stand)
                          : Container(),
                      (snapshot.data as RfidstandKonfiguration)
                              .hatNachlaufsperre
                          ? SizedBox(
                              height: 15,
                            )
                          : Container(),
                      (snapshot.data as RfidstandKonfiguration)
                              .hatNachlaufsperre
                          ? NachlaufsperreWidget(widget.stand)
                          : Container(),
                      (snapshot.data as RfidstandKonfiguration).hatTuer1
                          ? TuerWidget(widget.stand)
                          : Container(),
                      (snapshot.data as RfidstandKonfiguration).hatDosierer1
                          ? DosiererWidget(widget.stand)
                          : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
