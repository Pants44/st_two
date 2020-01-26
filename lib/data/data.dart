import 'package:st_two/data/connect.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiscoveryMethod {
  final String discoverymethod;
  final int dmid, rowrevnum, company;
  final bool inactive;

  DiscoveryMethod({
    this.dmid,
    this.inactive,
    this.discoverymethod,
    this.rowrevnum,
    this.company
  });

  factory DiscoveryMethod.fromJson(Map<String, dynamic> parsedJson){

    return DiscoveryMethod(
      dmid: int.tryParse(parsedJson['dmid']),
      inactive: bool.fromEnvironment(parsedJson['inactive']),
      discoverymethod: parsedJson['discoverymethod'],
      rowrevnum: int.tryParse(parsedJson['rowrevnum']),
      company: int.tryParse(parsedJson['company'])
    );
  }
}

class IndustryList {
  final List<Industry> industries;

  IndustryList({
    this.industries
  });

  factory IndustryList.fromJson(List<dynamic> parsedJson) {
    List<Industry> industries = new List<Industry>();
    industries = parsedJson.map((i)=>Industry.fromJson(i)).toList();

    return new IndustryList(
        industries: industries
    );
  }

  Future<IndustryList> fetch() async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();

    var jsonString = await http.get(sci.serverreqaddress + "/industries");
    final jsonResponse = json.decode(jsonString.body.toString());
    IndustryList industrylist = new IndustryList.fromJson(jsonResponse);
    return industrylist;
  }

}

class Industry {
  final String industryname;
  final int industryid, rowrevnum, company;
  final bool inactive;

  Industry({
    this.industryid,
    this.inactive,
    this.industryname,
    this.rowrevnum,
    this.company,
  });

  factory Industry.fromJson(Map<String, dynamic> parsedJson){

    return Industry(
      industryid: int.tryParse(parsedJson['industryid']),
      inactive: bool.fromEnvironment(parsedJson['inactive']),
      industryname: parsedJson['industryname'],
      rowrevnum: int.tryParse(parsedJson['rowrevnum']),
      company: int.tryParse(parsedJson['company']),
    );
  }

  Future<Industry> fetch(int industryid, int company) async {
    final sci = new ServerConnectionInfo();
    await sci.getServerInfo();

    var jsonString = await http.get(sci.serverreqaddress + "/industries/$industryid");
    final jsonResponse = json.decode(jsonString.body.toString());
    Industry industry = new Industry.fromJson(jsonResponse);
    return industry;
  }

}