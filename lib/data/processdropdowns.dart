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
  final String id, selection;

  Customerdd({
    this.id,
    this.selection
  });

  factory Customerdd.fromJson(Map<String, dynamic> parsedJson){
    return Customerdd(
      id: parsedJson['id'],
      selection: parsedJson['selection'],
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
  final String id, selection;

  Resourcedd({
    this.id,
    this.selection
  });

  factory Resourcedd.fromJson(Map<String, dynamic> parsedJson){
    return Resourcedd(
      id: parsedJson['id'],
      selection: parsedJson['selection'],
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
  final String id, selection;

  Statusdd({
    this.id,
    this.selection
  });

  factory Statusdd.fromJson(Map<String, dynamic> parsedJson){
    return Statusdd(
      id: parsedJson['id'],
      selection: parsedJson['selection'],
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

  factory Versiondd.fromJson(Map<String, dynamic> parsedJson){
    return Versiondd(
        id: parsedJson['id']
    );
  }
}

class GraphSelectionListdd{
  final List<GraphSelectiondd> graphs;

  GraphSelectionListdd({
    this.graphs
  });

  factory GraphSelectionListdd.fromJson(List<dynamic> parsedJson){
    List<GraphSelectiondd> graphs = new List<GraphSelectiondd>();
    graphs = parsedJson.map((i)=>GraphSelectiondd.fromJson(i)).toList();

    return new GraphSelectionListdd(
      graphs: graphs
    );
  }
}

class GraphSelectiondd {
  final String id;

  GraphSelectiondd({
    this.id
  });

  factory GraphSelectiondd.fromJson(Map<String, dynamic> parsedJson){
    return GraphSelectiondd(
      id: parsedJson['id']
    );
  }
}

class GraphRangeSelectionListdd{
  final List<GraphRangeSelectiondd> graphselections;

  GraphRangeSelectionListdd({
    this.graphselections
  });

  factory GraphRangeSelectionListdd.fromJson(List<dynamic> parsedJson){
    List<GraphRangeSelectiondd> graphselections = new List<GraphRangeSelectiondd>();
    graphselections = parsedJson.map((i)=>GraphRangeSelectiondd.fromJson(i)).toList();

    return new GraphRangeSelectionListdd(
        graphselections: graphselections
    );
  }
}

class GraphRangeSelectiondd {
  final String id;

  GraphRangeSelectiondd({
    this.id
  });

  factory GraphRangeSelectiondd.fromJson(Map<String, dynamic> parsedJson){
    return GraphRangeSelectiondd(
        id: parsedJson['id']
    );
  }
}