import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:piflutter/models/entities/fuetterung.dart';
import 'package:piflutter/models/entities/pferd.dart';
import 'package:piflutter/models/entities/schleusung.dart';
import 'package:piflutter/models/value_objects/rfid.dart';
import 'package:piflutter/models/entities/rfidstand.dart';
import 'package:uuid/uuid.dart';

class Service {
  static Service? _instance;

  Service._internal();

  static Service getInstance() {
    if (_instance == null) {
      _instance = Service._internal();
    }

    return _instance!;
  }

  final couchUrl = 'http://192.168.77.1:5984/';
  final baseApiUrl = 'http://192.168.77.1:8080/api/';
  final uuid = Uuid();
  Future<String> getRfid() async {
    var url = Uri.parse('http://192.168.77.1:8080/api/rfid');
    var response = await http.get(url);
    var data = Rfid.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    //debugPrint(data);
    return data.rfid;
  }

  // ignore: non_constant_identifier_names
  Future<bool> hat_nachlaufsperre(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/hat_nachlaufsperre');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(data);
    return data;
  }

  Future<RfidstandKonfiguration> getKonfiguration(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/config');
    var conf;
    try {
      var response = await http.get(url);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      conf = RfidstandKonfiguration.fromJson(data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
    return conf;
  }

  void openNls(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/opennls');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(data);
  }

  void closeNls(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/closenls');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(data);
  }

  void openTuer(String ip, int nr) {
    var url;
    if (nr == 1) {
      url = Uri.parse('http://' + ip + ':8080/api/opentuer1');
    } else {
      url = Uri.parse('http://' + ip + ':8080/api/opentuer2');
    }
    http.get(url);
  }

  void closeTuer(String ip, int nr) {
    var url;
    if (nr == 1) {
      url = Uri.parse('http://' + ip + ':8080/api/closetuer1');
    } else {
      url = Uri.parse('http://' + ip + ':8080/api/closetuer2');
    }
    http.get(url);
  }

  void openDoor(String ip, String tuername) async {
    if (tuername == 'Tür 1') {
      var url = Uri.parse('http://' + ip + ':8080/api/opentuer1');
      var response = await http.get(url);
      var data = (response.body);
      debugPrint(data);
    } else {
      var url = Uri.parse('http://' + ip + ':8080/api/opentuer2');
      var response = await http.get(url);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint(data);
    }
  }

  void closeDoor(String ip, String tuername) async {
    if (tuername == 'Tür 1') {
      var url = Uri.parse('http://' + ip + ':8080/api/closetuer1');
      var response = await http.get(url);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint(data);
    } else {
      var url = Uri.parse('http://' + ip + ':8080/api/closetuer2');
      var response = await http.get(url);
      var data = (utf8.decode(response.bodyBytes));
      debugPrint(data);
    }
  }

  void startDosierer(String ip, String dosierername) {
    print("Starte " + dosierername);
    if (dosierername == 'Dosierer 1') {
      var url = Uri.parse('http://' + ip + ':8080/api/startdosierer1');
      http.get(url);
      //var data = (response.body);
      //debugPrint(data);
    } else {
      var url = Uri.parse('http://' + ip + ':8080/api/startdosierer2');
      http.get(url);
      //var data = jsonDecode(utf8.decode(response.bodyBytes));
      //debugPrint(data);
    }
  }

  void stopDosierer(String ip, String dosierername) {
    print("Stoppe " + dosierername);
    if (dosierername == 'Dosierer 1') {
      var url = Uri.parse('http://' + ip + ':8080/api/stoppdosierer1');
      http.get(url);
      // var response = await http.get(url);
      // var data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data);
    } else {
      var url = Uri.parse('http://' + ip + ':8080/api/stoppdosierer2');
      http.get(url);
      //var response = await http.get(url);
      //var data = (utf8.decode(response.bodyBytes));
      //debugPrint(data);
    }
  }

  void openFutterschieber(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/openfutterschieber');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    debugPrint(data);
  }

  void closeFutterschieber(String ip) async {
    var url = Uri.parse('http://' + ip + ':8080/api/closefutterschieber');
    var response = await http.get(url);
    var data = (response.body);
    debugPrint(data);
  }

  void testSchleusung(String ip, String tuername) async {
    if (tuername == 'Tür 1') {
      var url =
          Uri.parse('http://' + ip + ':8080/api/testdurchlaufschleusetuer1');
      var response = await http.get(url);
      var data = (response.body);
      debugPrint(data);
    } else {
      var url =
          Uri.parse('http://' + ip + ':8080/api/testdurchlaufschleusetuer2');
      var response = await http.get(url);
      var data = (response.body);
      debugPrint(data);
    }
  }

  Future<List<Fuetterung>> getFuetterungen({required String pferdid}) async {
    var url = Uri.parse(couchUrl +
        'fuetterungen/_design/summe/_view/alle?key="' +
        pferdid +
        '"');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    //print(data['rows']);
    List<Fuetterung> fuetterungen = [];
    for (final p in data['rows']) {
      print(p);
      fuetterungen.add(Fuetterung.fromJson(p['value']));
    }
    //descending
    fuetterungen.sort((a, b) => b.compareTo(a));
    return fuetterungen;
  }

  Future<List<Schleusung>> getSchleusungen({required String pferdid}) async {
    var url = Uri.parse(couchUrl +
        'schleusungen/_design/liste/_view/alle?key="' +
        pferdid +
        '"');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    //print(data['rows']);
    List<Schleusung> schleusungen = [];
    for (final p in data['rows']) {
      print(p);
      schleusungen.add(Schleusung.fromJson(p['value']));
    }
    //descending
    schleusungen.sort((a, b) => b.compareTo(a));
    return schleusungen;
  }

  Future<List<Pferd>> getPferde() async {
    debugPrint('getPferde');
    var url = Uri.parse(couchUrl + 'pferde/_design/liste/_view/alle');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    //print(data['rows']);
    List<Pferd> pferde = [];
    for (final p in data['rows']) {
      print(p);
      Pferd horse = Pferd.fromJson(p['value']);
      print(horse);
      pferde.add(horse);
    }
    print(pferde.length);
    return pferde;
  }

  Future<http.Response> getFuetterungenLast24h(String rfid) async {
    var url = Uri.parse(couchUrl + 'fuetterungen/_design/summe/_view/last24h');
    var response = await http.get(url);
    return response;
  }

  Future<Pferd> getPferd(String id) async {
    var url = Uri.parse(couchUrl + 'pferde/$id');
    var response = await http.get(url);
    var pferd = Pferd.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return pferd;
  }

  Future<Pferd?> getPferdWithRfid(String rfid) async {
    if (rfid.isNotEmpty) {
      var pferd = await getPferdWithRfid_1(rfid);
      if (pferd == null) {
        pferd = await getPferdWithRfid_2(rfid);
      }

      return pferd;
    }
  }

  Future<Pferd?> getPferdWithRfid_1(String rfid) async {
    assert(rfid.isNotEmpty, 'Rfid darf nicht leer sein');
    var url =
        Uri.parse(couchUrl + 'pferde/_design/liste/_view/search?key="$rfid"');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Pferd> pferde = [];
    for (final p in data['rows']) {
      pferde.add(Pferd.fromJson(p['value']));
    }
    Pferd? pferd;
    if (pferde.length > 0) {
      pferd = pferde[0];
    }

    return pferd;
  }

  Future<Pferd?> getPferdWithRfid_2(String rfid) async {
    var url =
        Uri.parse(couchUrl + 'pferde/_design/liste/_view/search_2?key="$rfid"');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Pferd> pferde = [];
    for (final p in data['rows']) {
      pferde.add(Pferd.fromJson(p['value']));
    }
    Pferd? pferd;
    if (pferde.length > 0) {
      pferd = pferde[0];
    }

    return pferd;
  }

  Future<http.StreamedResponse> savePferd(Pferd pferd) async {
    Pferd horse;
    if (pferd.id == null) {
      horse = pferd.copyWith(id: uuid.v1());
    } else {
      horse = pferd.copyWith();
    }

    Future<http.StreamedResponse> response;
    var url;
    url = Uri.parse(couchUrl + "pferde/" + horse.id!);
    var req = Request('put', url);
    req.body = jsonEncode(horse);
    response = req.send();
    return response;
  }

  Future<http.Response> deletePferd(Pferd pferd) async {
    var url =
        Uri.parse(couchUrl + "pferde/" + pferd.id! + "?rev=" + pferd.rev!);
    var response = http.delete(url);
    return response;
  }

  Future<String> getUuid() async {
    var url = Uri.parse(couchUrl + '_uuids');
    var response = await http.get(url);
    var uuids = jsonDecode(response.body);

    return uuids["uuids"][0];
  }
/*
  Future<http.Response> simulierePferdImStand(pferd: Pferd): Observable<any> {
    return this.http.get('/api/rfid_gelesen?rfid=' + pferd.rfid);
  }*/

  Future<List<Rfidstand>> findstaende() async {
    var url = Uri.parse(couchUrl + 'staende/_design/liste/_view/alle');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Rfidstand> staende = [];
    for (final p in data['rows']) {
      staende.add(Rfidstand.fromJson(p['value']));
    }
    print(staende[0].name);
    return staende;
  }

  Future<Rfidstand> getStand(String id) async {
    var url = Uri.parse(couchUrl + 'staende/' + id);
    var response = await http.get(url);

    var stand = Rfidstand.fromJson(jsonDecode(response.body));

    return stand;
  }

  Future<Response> saveStand(Rfidstand stand) async {
    var url = Uri.parse(couchUrl + 'staende/' + stand.id);
    final req = Request('put', url);
    req.body = jsonEncode(stand);
    final response = await req.send();
    return Response.fromStream(response);
  }
}

class CouchResponse {
  String id;
  String rev;
  bool ok;
  CouchResponse(this.id, this.rev, this.ok);
}
