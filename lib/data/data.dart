import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParseResponse {
  ParseResponse();

  Future<String> parse(http.Response res, [BuildContext context, bool noexit = false]) async {
    if (res != null) {
      print('');
      print('StatusCode: ' + res.statusCode.toString());
      print('Method: ' + res.request.method);
      print('Body: ' + res.body.toString());
      print('URL: ' + res.request.url.toString());
      print('Headers: ' + res.request.headers.toString());
      print('ReasonPhrase: ' + res.reasonPhrase);
      print('No exit: ' + noexit.toString());
      print('');

      if (context != null) {
        switch (res.statusCode) {
          case 200:
              showDialog(
                context: context,
                child: Center(
                  child: Container(
                    child: AlertDialog(content: Icon(Icons.check)),
                  ),
                ),
              );
              if(noexit){
                Future.delayed(Duration(seconds: 1))
                    .then((v) => Navigator.of(context).pop());
                
                
              }else{
                print('should have popped');
                Future.delayed(Duration(seconds: 1))
                    .then((v) => Navigator.of(context).pop())
                    .then((v) => Navigator.of(context).pop());
              }
              return 'success';
            break;
          case 500:
            if (res.body.contains(
                'PostgreSQLSeverity.error P0001: This row has been modified by another user')) {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Row Modified'),
                    content: Text(
                        'Row has been modified by another user. What would you like to do?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Accept & Merge'),
                      ),
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
              return 'rowmodified';
            } else {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('sumtim went really bad, bruda'),
                  ));
              return 'failed';
            }

            break;
          default:
            print('no catch built for response');
            return 'failed';
            break;
        }
      }
    } else {
      if (context != null) {
        print('Could not connect to Server');
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('no connection, bruda'),
          ),
        );
      }
      return 'failed';
    }
  }
}
