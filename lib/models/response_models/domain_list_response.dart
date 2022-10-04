class DomainListResponse {
  List<Domain>? doaminList;
  int? hydraTotalItems;
  HydraView? hydraView;
  HydraSearch? hydraSearch;

  DomainListResponse(
      {this.doaminList,
      this.hydraTotalItems,
      this.hydraView,
      this.hydraSearch});

  DomainListResponse.fromJson(Map<String, dynamic> json) {
    if (json['hydra:member'] != null) {
      doaminList = <Domain>[];
      json['hydra:member'].forEach((v) {
        doaminList!.add(Domain.fromJson(v));
      });
    }
    hydraTotalItems = json['hydra:totalItems'];
    hydraView = json['hydra:view'] != null
        ? HydraView.fromJson(json['hydra:view'])
        : null;
    hydraSearch = json['hydra:search'] != null
        ? HydraSearch.fromJson(json['hydra:search'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doaminList != null) {
      data['hydra:member'] = doaminList!.map((v) => v.toJson()).toList();
    }
    data['hydra:totalItems'] = hydraTotalItems;
    if (hydraView != null) {
      data['hydra:view'] = hydraView!.toJson();
    }
    if (hydraSearch != null) {
      data['hydra:search'] = hydraSearch!.toJson();
    }
    return data;
  }
}

class Domain {
  String? atId;
  String? type;
  String? context;
  String? id;
  String? domain;
  bool? isActive;
  bool? isPrivate;
  String? createdAt;
  String? updatedAt;

  Domain(
      {this.atId,
      this.type,
      this.context,
      this.id,
      this.domain,
      this.isActive,
      this.isPrivate,
      this.createdAt,
      this.updatedAt});

  Domain.fromJson(Map<String, dynamic> json) {
    atId = json['@id'];
    type = json['@type'];
    context = json['@context'];
    id = json['id'];
    domain = json['domain'];
    isActive = json['isActive'];
    isPrivate = json['isPrivate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = atId;
    data['@type'] = type;
    data['@context'] = context;
    data['id'] = id;
    data['domain'] = domain;
    data['isActive'] = isActive;
    data['isPrivate'] = isPrivate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class HydraView {
  String? id;
  String? type;
  String? hydraFirst;
  String? hydraLast;
  String? hydraPrevious;
  String? hydraNext;

  HydraView(
      {this.id,
      this.type,
      this.hydraFirst,
      this.hydraLast,
      this.hydraPrevious,
      this.hydraNext});

  HydraView.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
    type = json['@type'];
    hydraFirst = json['hydra:first'];
    hydraLast = json['hydra:last'];
    hydraPrevious = json['hydra:previous'];
    hydraNext = json['hydra:next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = id;
    data['@type'] = type;
    data['hydra:first'] = hydraFirst;
    data['hydra:last'] = hydraLast;
    data['hydra:previous'] = hydraPrevious;
    data['hydra:next'] = hydraNext;
    return data;
  }
}

class HydraSearch {
  String? type;
  String? hydraTemplate;
  String? hydraVariableRepresentation;
  List<HydraMapping>? hydraMapping;

  HydraSearch(
      {this.type,
      this.hydraTemplate,
      this.hydraVariableRepresentation,
      this.hydraMapping});

  HydraSearch.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    hydraTemplate = json['hydra:template'];
    hydraVariableRepresentation = json['hydra:variableRepresentation'];
    if (json['hydra:mapping'] != null) {
      hydraMapping = <HydraMapping>[];
      json['hydra:mapping'].forEach((v) {
        hydraMapping!.add(HydraMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['hydra:template'] = hydraTemplate;
    data['hydra:variableRepresentation'] = hydraVariableRepresentation;
    if (hydraMapping != null) {
      data['hydra:mapping'] = hydraMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HydraMapping {
  String? type;
  String? variable;
  String? property;
  bool? required;

  HydraMapping({this.type, this.variable, this.property, this.required});

  HydraMapping.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    variable = json['variable'];
    property = json['property'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['variable'] = variable;
    data['property'] = property;
    data['required'] = required;
    return data;
  }
}
