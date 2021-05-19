import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   final channel = IOWebSocketChannel.connect('ws://192.168.77.1:8080/ws');

//   channel.stream.listen((message) {
//     channel.sink.add('received!');
//     channel.sink.close(status.goingAway);
//   });
//}

class Meldungen extends StatefulWidget {
  @override
  _MeldungenState createState() => _MeldungenState();
}

class _MeldungenState extends State<Meldungen> {
  //late WebSocketChannel _channel;
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://192.168.77.1:8080/ws'));
  final channel_2 =
      WebSocketChannel.connect(Uri.parse('ws://192.168.77.2:8080/ws'));
  // _connectSocketChannel() {
  //   _channel = IOWebSocketChannel.connect('ws://192.168.77.1:8080/ws');
  // }

  @override
  void initState() {
    super.initState();
    //_connectSocketChannel();
    channel.stream.listen((event) {
      var msg = jsonDecode(event);

      setState(() {
        messages.insert(0, msg);
      });
    });

    channel_2.stream.listen((event) {
      var msg = jsonDecode(event);

      setState(() {
        messages.insert(0, msg);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    channel_2.sink.close();
    super.dispose();
  }

  final messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meldungen der Steuerung'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // StreamBuilder(
            //     stream: channel.stream,
            //     builder: (context, snapshot) {
            //       // return Padding(
            //       //   padding: EdgeInsets.symmetric(vertical: 24),
            //       //   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //       // );
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }

            //       return Padding(
            //         padding: EdgeInsets.symmetric(vertical: 24),
            //         child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //       );
            //     }),
            // Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(messages[index]['uhrzeit']),
                      subtitle: Text(messages[index]['message']),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
