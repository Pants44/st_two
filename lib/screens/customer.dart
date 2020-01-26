import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/size_config.dart';

TextEditingController tecCustomerId = TextEditingController();
TextEditingController tecCustomerName = TextEditingController();
TextEditingController tecMainPOCName = TextEditingController();
TextEditingController tecMainPOCEmail = TextEditingController();
TextEditingController tecDiscoveryId = TextEditingController();
TextEditingController tecReferredById = TextEditingController();
TextEditingController tecReferredBy = TextEditingController();
TextEditingController tecIndustryId = TextEditingController();
TextEditingController tecIndustryName = TextEditingController();
TextEditingController tecPortalLogin = TextEditingController();
TextEditingController tecPortalPassword = TextEditingController();
TextEditingController tecSpecialInstructions = TextEditingController();
TextEditingController tecSpecialInstructionsDesc = TextEditingController();
TextEditingController tecDiscoveryDescription = TextEditingController();
TextEditingController tecEnteredBy = TextEditingController();
TextEditingController tecEnteredDate = TextEditingController();

String vmode = '';
String vtitle = '';
bool vronly = false;
bool vinbool = false;
bool vsibool = false;
bool vengagebool = false;
bool vquotereqbool = false;
bool vconnsetupbool = false;
bool vonholdbool = false;
bool vblacklistbool = false;
bool vautoemailbool = false;
bool vmonthsupportbool = false;

class CustomerPage extends StatefulWidget {
  final String mode;
  final bool ronly;
  final String title;
  final Customer customer;

  CustomerPage({Key key, this.mode, this.ronly, this.title, this.customer})
      : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    vmode = widget.mode.toString();
    vtitle = widget.title.toString();
    vronly = widget.ronly;
    if (vmode == 'edit') {
      _loadData(widget.customer);
    } else if (vmode == 'add') {
      tecCustomerId.text = '';
      tecCustomerName.text = '';
      tecMainPOCName.text = '';
      tecMainPOCEmail.text = '';
      tecDiscoveryId.text = '';
      tecReferredById.text = '';
      tecReferredBy.text = '';
      tecIndustryId.text = '';
      tecIndustryName.text = '';
      tecPortalLogin.text = '';
      tecPortalPassword.text = '';
      tecSpecialInstructions.text = '';
      tecSpecialInstructionsDesc.text = '';
      tecDiscoveryDescription.text = '';
      vinbool = false;
      vsibool = false;
      vengagebool = false;
      vquotereqbool = false;
      vconnsetupbool = false;
      vonholdbool = false;
      vblacklistbool = false;
      vautoemailbool = false;
      vmonthsupportbool = false;
      tecEnteredBy.text = '';
      tecEnteredDate.text = '';
    }
  }

  @override
  void dispose() {
    tecCustomerId.text = '';
    tecCustomerName.text = '';
    tecMainPOCName.text = '';
    tecMainPOCEmail.text = '';
    tecDiscoveryId.text = '';
    tecReferredById.text = '';
    tecReferredBy.text = '';
    tecIndustryId.text = '';
    tecIndustryName.text = '';
    tecPortalLogin.text = '';
    tecPortalPassword.text = '';
    tecSpecialInstructionsDesc.text = '';
    tecDiscoveryDescription.text = '';
    tecEnteredBy.text = '';
    tecEnteredDate.text = '';
    super.dispose();
  }

  void _loadData(Customer c) {
    tecCustomerId.text = c.customerid.toString();
    tecCustomerName.text = c.customername.toString();
    tecMainPOCName.text = c.mainpocname.toString();
    tecMainPOCEmail.text = c.mainpocemail.toString();
    tecDiscoveryId.text = c.discoverymethodid.toString();
    tecReferredById.text = c.referredbyid.toString();
    tecReferredBy.text = c.referredby.toString();
    tecIndustryId.text = c.industryid.toString();
    tecIndustryName.text = c.industryname.toString();
    tecPortalLogin.text = c.portallogin.toString();
    tecPortalPassword.text = c.portalpassword.toString();
    tecSpecialInstructions.text = c.specialinstructions.toString();
    tecSpecialInstructionsDesc.text = c.sidescription.toString();
    tecDiscoveryDescription.text = c.dmdescription.toString();
    vinbool = c.inactive;
    vsibool = c.specialinstructions;
    vengagebool = c.engagementreceived;
    vquotereqbool = c.quotesrequired;
    vconnsetupbool = c.connectionsetup;
    vonholdbool = c.onhold;
    vblacklistbool = c.blacklisted;
    vautoemailbool = c.autoemail;
    vmonthsupportbool = c.monthlysupport;
    tecEnteredBy.text = c.enteredby.toString();
    tecEnteredDate.text = c.entereddate.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.all(8),
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'General',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        controller: tecCustomerName,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Main POC Name',
                        ),
                        controller: tecMainPOCName,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Main POC Email',
                        ),
                        controller: tecMainPOCEmail,
                        readOnly: vronly,
                      ),
                      CheckboxListTile(
                        value: vsibool,
                        title: Text('Special Instructions?'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Special Intstructions Description',
                        ),
                        controller: tecSpecialInstructionsDesc,
                        readOnly: vronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      CheckboxListTile(
                        value: vinbool,
                        title: Text('Inactive'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vengagebool,
                        title: Text('Engagement Received'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vquotereqbool,
                        title: Text('Quotes Required'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vconnsetupbool,
                        title: Text('Connection Setup'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vonholdbool,
                        title: Text('On Hold'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vblacklistbool,
                        title: Text('Blacklisted'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vautoemailbool,
                        title: Text('Auto Email'),
                        onChanged: vronly ? null : (value) {},
                      ),
                      CheckboxListTile(
                        value: vmonthsupportbool,
                        title: Text('Monthly Support'),
                        onChanged: vronly ? null : (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Industry',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Industry Name'
                        ),
                        controller: tecIndustryName,
                        readOnly: vronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Discovery',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Discovery Method',
                        ),
                        controller: tecDiscoveryDescription,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Refered By',
                        ),
                        controller: tecReferredBy,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Other',
                        ),
                        readOnly: vronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'ST Portal',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Login',
                        ),
                        controller: tecPortalLogin,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Pass',
                        ),
                        controller: tecPortalPassword,
                        readOnly: vronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Misc',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Entered By',
                        ),
                        controller: tecEnteredBy,
                        readOnly: vronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Entered Date',
                        ),
                        controller: tecEnteredDate,
                        readOnly: vronly,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 72),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
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
}
