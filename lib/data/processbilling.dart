class BillingWeek {

  final List<BillingDayList> billingdayslist;

  BillingWeek({
    this.billingdayslist
  });

  factory BillingWeek.fromJson(List<dynamic> parsedJson){
    List<BillingDayList> billingdaylist = new List<BillingDayList>();
    billingdaylist = parsedJson.map((i)=>BillingDayList.fromJson(i)).toList();
    return new BillingWeek(
      billingdayslist: billingdaylist
    );
  }

}


class BillingDayList{
  final int billingweekid;
  final String billdate, billdayofweek, billingtotalday;
  final List<BillingEntry> billingentries;

  BillingDayList({
    this.billingweekid,
    this.billdate,
    this.billdayofweek,
    this.billingtotalday,
    this.billingentries,
  });

  factory BillingDayList.fromJson(Map<String, dynamic> parsedJson){
    var belist = parsedJson['billingentries'] as List;
    List<BillingEntry> billingentries = belist.map((i) => BillingEntry.fromJson(i)).toList();

    return new BillingDayList(
      billingweekid: int.parse(parsedJson['billingweekid']),
      billdate: parsedJson['billdate'],
      billdayofweek: parsedJson['billdayofweek'],
      billingtotalday: parsedJson['billingtotalday'],
      billingentries: billingentries
    );
  }

}

class BillingEntry {
  final List<TimePeriod> timeperiods;
  final String ticket, customer, poc, resource, billingservicelevel, billedtime, extratime, notes, internalnotes;

  BillingEntry({
    this.ticket,
    this.customer,
    this.poc,
    this.resource,
    this.billingservicelevel,
    this.billedtime,
    this.timeperiods,
    this.extratime,
    this.notes,
    this.internalnotes
  });

  factory BillingEntry.fromJson(Map<String, dynamic> parsedJson){

    var tplist = parsedJson['timeperiods'] as List;
    List<TimePeriod> timeperiodList = tplist.map((i) => TimePeriod.fromJson(i)).toList();

    return BillingEntry(
      ticket: parsedJson['ticket'],
      customer: parsedJson['customer'],
      poc: parsedJson['poc'],
      resource: parsedJson['resource'],
      billingservicelevel: parsedJson['billingservicelevel'],
      billedtime: parsedJson['billedtime'],
      extratime: parsedJson['extratime'],
      notes: parsedJson['notes'],
      internalnotes: parsedJson['internalnotes'],
      timeperiods: timeperiodList

    );
  }
}

class TimePeriod {

  final int periodid;
  final String starttime, endtime;

  TimePeriod({
    this.periodid,
    this.starttime,
    this.endtime
  });

  factory TimePeriod.fromJson(Map<String, dynamic> parsedJson){

    return TimePeriod(
      periodid: int.parse(parsedJson['periodid']),
      starttime: parsedJson['starttime'],
      endtime: parsedJson['endtime']
    );
  }

}