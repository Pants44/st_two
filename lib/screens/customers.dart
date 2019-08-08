import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/screens/customerentry.dart';

class CustomersPage extends StatefulWidget {
  CustomersPage({Key key, this.title}) : super(key: key);
  final title;

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(widget.title),
          actions: <Widget>[
            Hero(
              tag: 'logoappbar',
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 5),
                child: Image(
                  image: AssetImage('assets/st22000.png'),
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: loadCustomerList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.customers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerEntry(
                                        title: snapshot
                                            .data.customers[index].customername,
                                        customer:
                                            snapshot.data.customers[index])),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(snapshot
                                        .data.customers[index].customerid
                                        .toString() +
                                    " - " +
                                    snapshot.data.customers[index].customername
                                        .toString()),
                              ),
                            ));
                      },
                    )
                  : Center(child: CircularProgressIndicator());
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  Future<CustomerList> loadCustomerList() async {
    print('func called');
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/customerdata.json");
    final jsonResponse = json.decode(jsonString);
    CustomerList customerlist = new CustomerList.fromJson(jsonResponse);
    print('Customers list loaded for Customer List Screen');
    return customerlist;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
