import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomers.dart';
import 'package:st_two/size_config.dart';

bool ronly = false;

class CustomerEntry extends StatefulWidget {
  CustomerEntry({Key key, this.title, this.customer, this.readonly})
      : super(key: key);
  final String title;
  final bool readonly;
  final customer;

  @override
  _CustomerEntryState createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  TextEditingController tecCustomerId = TextEditingController();
  TextEditingController tecCustomerName = TextEditingController();
  TextEditingController tecMainPOCName = TextEditingController();
  TextEditingController tecMainPOCEmail = TextEditingController();
  TextEditingController tecDiscoveryId = TextEditingController();
  TextEditingController tecReferredById = TextEditingController();
  TextEditingController tecReferredBy = TextEditingController();
  TextEditingController tecIndustryId = TextEditingController();
  TextEditingController tecPortalLogin = TextEditingController();
  TextEditingController tecPortalPassword = TextEditingController();
  TextEditingController tecSpecialInstructions = TextEditingController();
  TextEditingController tecSpecialInstructionsDesc = TextEditingController();
  TextEditingController tecDiscoveryDescription = TextEditingController();
  TextEditingController tecInactive = TextEditingController();
  TextEditingController tecEngagementReceived = TextEditingController();
  TextEditingController tecQuotesRequired = TextEditingController();
  TextEditingController tecConnectionSetup = TextEditingController();
  TextEditingController tecOnHold = TextEditingController();
  TextEditingController tecBlacklisted = TextEditingController();
  TextEditingController tecAutoEmail = TextEditingController();
  TextEditingController tecMonthlySupport = TextEditingController();
  TextEditingController tecEnteredBy = TextEditingController();
  TextEditingController tecEnteredDate = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadData(widget.customer);
    this._editCustomerState(widget.readonly);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tecCustomerId.dispose();
    tecCustomerName.dispose();
    tecMainPOCName.dispose();
    tecMainPOCEmail.dispose();
    tecDiscoveryId.dispose();
    tecReferredById.dispose();
    tecReferredBy.dispose();
    tecIndustryId.dispose();
    tecPortalLogin.dispose();
    tecPortalPassword.dispose();
    tecSpecialInstructions.dispose();
    tecSpecialInstructionsDesc.dispose();
    tecDiscoveryDescription.dispose();
    tecInactive.dispose();
    tecEngagementReceived.dispose();
    tecQuotesRequired.dispose();
    tecConnectionSetup.dispose();
    tecOnHold.dispose();
    tecBlacklisted.dispose();
    tecAutoEmail.dispose();
    tecMonthlySupport.dispose();
    tecEnteredBy.dispose();
    tecEnteredDate.dispose();
    super.dispose();
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
                elevation: 10,
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
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Main POC Name',
                        ),
                        controller: tecMainPOCName,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Main POC Email',
                        ),
                        controller: tecMainPOCEmail,
                        readOnly: ronly,
                      ),
                      CheckboxListTile(
                        value: widget.customer.specialinstructions,
                        title: Text('Special Instructions?'),
                        onChanged: (value) {},
                      ),
                      TextFormField(
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Special Intstructions Description',
                        ),
                        controller: tecSpecialInstructionsDesc,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
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
                        value: widget.customer.inactive,
                        title: Text('Inactive'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.engagementreceived,
                        title: Text('Engagement Received'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.quotesrequired,
                        title: Text('Quotes Required'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.connectionsetup,
                        title: Text('Connection Setup'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.onhold,
                        title: Text('On Hold'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.blacklisted,
                        title: Text('Blacklisted'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.autoemail,
                        title: Text('Auto Email'),
                        onChanged: (value) {},
                      ),
                      CheckboxListTile(
                        value: widget.customer.monthlysupport,
                        title: Text('Monthly Support'),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Card(
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
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Refered By',
                        ),
                        controller: tecReferredBy,
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Other',
                        ),
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
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
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Pass',
                        ),
                        controller: tecPortalPassword,
                        readOnly: ronly,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
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
                        readOnly: ronly,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Entered Date',
                        ),
                        controller: tecEnteredDate,
                        readOnly: ronly,
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
        onPressed: (){

        },
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }

  void loadData(Customer c) {
    tecCustomerId.text = c.customerid.toString();
    tecCustomerName.text = c.customername.toString();
    tecMainPOCName.text = c.mainpocname.toString();
    tecMainPOCEmail.text = c.mainpocemail.toString();
    tecDiscoveryId.text = c.discoverymethodid.toString();
    tecReferredById.text = c.referredbyid.toString();
    tecReferredBy.text = c.referredby.toString();
    tecIndustryId.text = c.industryid.toString();
    tecPortalLogin.text = c.portallogin.toString();
    tecPortalPassword.text = c.portalpassword.toString();
    tecSpecialInstructions.text = c.specialinstructions.toString();
    tecSpecialInstructionsDesc.text = c.specialinstructionsdesc.toString();
    tecDiscoveryDescription.text = c.discoverydescription.toString();
    tecInactive.text = c.inactive.toString();
    tecEngagementReceived.text = c.engagementreceived.toString();
    tecQuotesRequired.text = c.quotesrequired.toString();
    tecConnectionSetup.text = c.connectionsetup.toString();
    tecOnHold.text = c.onhold.toString();
    tecBlacklisted.text = c.onhold.toString();
    tecAutoEmail.text = c.autoemail.toString();
    tecMonthlySupport.text = c.monthlysupport.toString();
    tecEnteredBy.text = c.enteredby.toString();
    tecEnteredDate.text = c.entereddate.toString();
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

  void _editCustomerState(bool readonly) {
    ronly = readonly;
  }
}
