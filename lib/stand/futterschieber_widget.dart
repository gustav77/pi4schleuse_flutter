import 'package:flutter/material.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/service/service.dart';

class FutterschieberWidget extends StatelessWidget {
  final Rfidstand stand;
  FutterschieberWidget(this.stand);
  final Service service = Service.getInstance();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Futterschieber',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      service.openFutterschieber(stand.ip);
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
                        service.closeFutterschieber(stand.ip);
                      },
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
