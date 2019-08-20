class CustomerListdd {
  final List<Customerdd> customers;

  CustomerListdd({
    this.customers
  });

  factory CustomerListdd.fromJson(List<dynamic> parseJson){
    List<Customerdd> customers = new List<Customerdd>();
    customers = parseJson.map((i)=>Customerdd.fromJson(i)).toList();

    return new CustomerListdd(
        customers: customers
    );
  }
}

class Customerdd {
  final String customerid, customername;

  Customerdd({
    this.customerid,
    this.customername
  });

  factory Customerdd.fromJson(Map<String, dynamic> parsedJson){
    return Customerdd(
      customerid: parsedJson['id'],
      customername: parsedJson['selection'],
    );
  }
}

class CustomerStatusListdd {
  final List<CustomerStatusdd> customerstatusi;

  CustomerStatusListdd ({
    this.customerstatusi
  });

  factory CustomerStatusListdd.fromJson(List<dynamic> parsedJson) {
    List<CustomerStatusdd> customerstatusi = new List<CustomerStatusdd>();
    customerstatusi = parsedJson.map((i)=>CustomerStatusdd.fromJson(i)).toList();

    return new CustomerStatusListdd(
        customerstatusi: customerstatusi
    );
  }
}

class CustomerStatusdd {
  final String id;

  CustomerStatusdd({
    this.id
  });

  factory CustomerStatusdd.fromJson(Map<String, dynamic> parseJson){
    return CustomerStatusdd(
      id: parseJson['id']
    );
  }
}

class ResourcesListdd {
  final List<Resourcedd> resources;

  ResourcesListdd({
    this.resources,
  });

  factory ResourcesListdd.fromJson(List<dynamic> parsedJson) {
    List<Resourcedd> resources = new List<Resourcedd>();
    resources = parsedJson.map((i)=>Resourcedd.fromJson(i)).toList();

    return new ResourcesListdd(
        resources: resources
    );
  }
}

class Resourcedd {
  final String resourceid, resourcename;

  Resourcedd({
    this.resourceid,
    this.resourcename
  });

  factory Resourcedd.fromJson(Map<String, dynamic> parsedJson){
    return Resourcedd(
      resourceid: parsedJson['id'],
      resourcename: parsedJson['selection'],
    );
  }
}

class StatusListdd {
  final List<Statusdd> statusi;

  StatusListdd({
    this.statusi
  });

  factory StatusListdd.fromJson(List<dynamic> parseJson){
    List<Statusdd> statusi = new List<Statusdd>();
    statusi = parseJson.map((i)=>Statusdd.fromJson(i)).toList();

    return new StatusListdd(
      statusi: statusi
    );
  }
}

class Statusdd {
  final String statusid, status;

  Statusdd({
    this.statusid,
    this.status
  });

  factory Statusdd.fromJson(Map<String, dynamic> parsedJson){
    return Statusdd(
      statusid: parsedJson['id'],
      status: parsedJson['selection'],
    );
  }
}

class VersionListdd {
  final List<Versiondd> versions;

  VersionListdd ({
    this.versions
  });

  factory VersionListdd.fromJson(List<dynamic> parsedJson) {
    List<Versiondd> versions = new List<Versiondd>();
    versions = parsedJson.map((i)=>Versiondd.fromJson(i)).toList();

    return new VersionListdd(
        versions: versions
    );
  }
}

class Versiondd {
  final String id;

  Versiondd({
    this.id
  });

  factory Versiondd.fromJson(Map<String, dynamic> parseJson){
    return Versiondd(
        id: parseJson['id']
    );
  }
}
