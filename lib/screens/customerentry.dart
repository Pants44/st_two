import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:st_two/data/processcustomers.dart';

class CustomerEntry extends StatefulWidget {
  CustomerEntry({Key key, this.title, this.customer}) : super(key: key);
  final title;
  final customer;

  @override
  _CustomerEntryState createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  TextEditingController tecCustomerId = TextEditingController();
  TextEditingController tecCustomerName = TextEditingController();
  TextEditingController tecDiscoveryId = TextEditingController();
  TextEditingController tecReferredById = TextEditingController();
  TextEditingController tecIndustryId = TextEditingController();
  TextEditingController tecPortalLogin = TextEditingController();
  TextEditingController tecPortalPassword = TextEditingController();
  TextEditingController tecSpecialInstructions = TextEditingController();
  TextEditingController tecSpecialInstructionsDescription =
      TextEditingController();
  TextEditingController tecDiscoveryDescription = TextEditingController();
  TextEditingController tecInactive = TextEditingController();
  TextEditingController tecEngagementReceived = TextEditingController();
  TextEditingController tecQuotesRequired = TextEditingController();
  TextEditingController tecConnectionSetup = TextEditingController();
  TextEditingController tecOnHold = TextEditingController();
  TextEditingController tecBlacklisted = TextEditingController();
  TextEditingController tecAutoEmail = TextEditingController();
  TextEditingController tecMonthlySupport = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadData(widget.customer);
  }

  void loadData(Customer c) {
    tecCustomerId.text = c.customerid.toString();
    tecCustomerName.text = c.customername.toString();
    tecDiscoveryId.text = c.discoverymethodid.toString();
    tecReferredById.text = c.referredbyid.toString();
    tecIndustryId.text = c.industryid.toString();
    tecPortalLogin.text = c.portallogin.toString();
    tecPortalPassword.text = c.portalpassword.toString();
    tecSpecialInstructions.text = c.specialinstructions.toString();
    tecSpecialInstructionsDescription.text =
        c.specialinstructionsdescription.toString();
    tecDiscoveryDescription.text = c.discoverydescription.toString();
    tecInactive.text = c.inactive.toString();
    tecEngagementReceived.text = c.engagementreceived.toString();
    tecQuotesRequired.text = c.quotesrequired.toString();
    tecConnectionSetup.text = c.connectionsetup.toString();
    tecOnHold.text = c.onhold.toString();
    tecBlacklisted.text = c.onhold.toString();
    tecAutoEmail.text = c.autoemail.toString();
    tecMonthlySupport.text = c.monthlysupport.toString();
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
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: tecCustomerId,
          ),
          TextField(
            controller: tecCustomerName,
          ),
          TextField(
            controller: tecIndustryId,
          ),
          TextField(
            controller: tecDiscoveryId,
          ),
          TextField(
            controller: tecReferredById,
          ),
          TextField(
            controller: tecPortalLogin,
          ),
          TextField(
            controller: tecPortalPassword,
          ),
          TextField(
            controller: tecSpecialInstructions,
          ),
          TextField(
            controller: tecSpecialInstructionsDescription,
          ),
          TextField(
            controller: tecDiscoveryDescription,
          ),
          TextField(
            controller: tecInactive,
          ),
          TextField(
            controller: tecEngagementReceived,
          ),
          TextField(
            controller: tecQuotesRequired,
          ),
          TextField(
            controller: tecConnectionSetup,
          ),
          TextField(
            controller: tecOnHold,
          ),
          TextField(
            controller: tecBlacklisted,
          ),
          TextField(
            controller: tecAutoEmail,
          ),
          TextField(
            controller: tecMonthlySupport,
          ),
        ],
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

  @override
  void dispose() {
    // TODO: implement dispose
    tecCustomerId.dispose();
    tecCustomerName.dispose();
    tecDiscoveryId.dispose();
    tecReferredById.dispose();
    tecIndustryId.dispose();
    tecPortalLogin.dispose();
    tecPortalPassword.dispose();
    tecSpecialInstructions.dispose();
    tecSpecialInstructionsDescription.dispose();
    tecDiscoveryDescription.dispose();
    tecInactive.dispose();
    tecEngagementReceived.dispose();
    tecQuotesRequired.dispose();
    tecConnectionSetup.dispose();
    tecOnHold.dispose();
    tecBlacklisted.dispose();
    tecAutoEmail.dispose();
    tecMonthlySupport.dispose();
    super.dispose();
  }
}
