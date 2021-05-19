import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:piflutter/pferde/pferde_liste.dart';
import 'package:piflutter/service/service.dart';
import 'package:piflutter/stand/meldungen.dart';
import 'package:piflutter/stand/stand_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Service service = Service.getInstance();
    // final staende = service.findstaende();
    // staende.then((value) {
    //   if (value != null) {
    //     print(value);
    //   }
    // }).onError((error, stackTrace) => null);
    return MaterialApp(
      title: 'Mapletec',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapletec'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 200, height: 100),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pferdeliste(),
                        ));
                  },
                  child: Text(
                    'Pferde',
                    style: TextStyle(fontSize: 32),
                  )),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 200, height: 100),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Standliste(),
                        ));
                  },
                  child: Text(
                    'Technik',
                    style: TextStyle(fontSize: 32),
                  )),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 200, height: 100),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Meldungen(),
                        ));
                  },
                  child: Text(
                    'Meldungen',
                    style: TextStyle(fontSize: 32),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class Standliste extends StatefulWidget {
  @override
  _StandlisteState createState() => _StandlisteState();
}

class _StandlisteState extends State<Standliste> {
  Service service = Service.getInstance();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text('Suche Stände'),
            ),
          );
        }
        if ((snapshot.data as List<Rfidstand>).length == 1) {
          return StandDetail((snapshot.data as List<Rfidstand>)[0]);
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Stände')),
          body: ListView.builder(
              itemCount: (snapshot.data as List<Rfidstand>).length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text((snapshot.data as List<Rfidstand>)[index].name),
                  subtitle: Text((snapshot.data as List<Rfidstand>)[index].ip),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StandDetail(
                              (snapshot.data as List<Rfidstand>)[index]),
                        ));
                  },
                  //subtitle: Text((snapshot.data[index].rfid ?? '') + ' '),
                );
              }),
        );
      },
      future: service.findstaende(),
    );
  }
}

showSpeicherToast(FToast fToast, String toastmsg, bool alertColor) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: alertColor ? Colors.redAccent : Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(alertColor ? Icons.error : Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text(toastmsg),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
