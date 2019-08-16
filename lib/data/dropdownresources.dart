class ResourcesList {
  final List<Resource> resources;

  ResourcesList({
    this.resources,
  });

  factory ResourcesList.fromJson(List<dynamic> parsedJson) {
    List<Resource> resources = new List<Resource>();
    resources = parsedJson.map((i)=>Resource.fromJson(i)).toList();

    return new ResourcesList(
        resources: resources
    );
  }
}

class Resource {
  final String resourceid, resourcename;

  Resource({
    this.resourceid,
    this.resourcename
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson){
    return Resource(
      resourceid: parsedJson['id'],
      resourcename: parsedJson['selection'],
    );
  }
}