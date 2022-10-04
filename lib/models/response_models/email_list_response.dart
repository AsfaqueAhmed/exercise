class EmailListResponse {
  List<Email>? emails;
  int? hydraTotalItems;
  HydraView? hydraView;
  HydraSearch? hydraSearch;

  EmailListResponse(
      {this.emails,
      this.hydraTotalItems,
      this.hydraView,
      this.hydraSearch});

  EmailListResponse.fromJson(Map<String, dynamic> json) {
    if (json['hydra:member'] != null) {
      emails = <Email>[];
      json['hydra:member'].forEach((v) {
        emails!.add(Email.fromJson(v));
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
    if (emails != null) {
      data['hydra:member'] = emails!.map((v) => v.toJson()).toList();
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

class Email {
  String? atId;
  String? type;
  String? context;
  String? id;
  String? accountId;
  String? msgid;
  SenderReceiver? from;
  List<SenderReceiver>? to;
  String? subject;
  String? intro;
  bool? seen;
  bool? isDeleted;
  bool? hasAttachments;
  int? size;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  Email(
      {this.atId,
      this.type,
      this.context,
      this.id,
      this.accountId,
      this.msgid,
      this.from,
      this.to,
      this.subject,
      this.intro,
      this.seen,
      this.isDeleted,
      this.hasAttachments,
      this.size,
      this.downloadUrl,
      this.createdAt,
      this.updatedAt});

  Email.fromJson(Map<String, dynamic> json) {
    atId = json['@id'];
    type = json['@type'];
    context = json['@context'];
    id = json['id'];
    accountId = json['accountId'];
    msgid = json['msgid'];
    from = json['from'] != null ? SenderReceiver.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = <SenderReceiver>[];
      json['to'].forEach((v) {
        to!.add(SenderReceiver.fromJson(v));
      });
    }
    subject = json['subject'];
    intro = json['intro'];
    seen = json['seen'];
    isDeleted = json['isDeleted'];
    hasAttachments = json['hasAttachments'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@id'] = atId;
    data['@type'] = type;
    data['@context'] = context;
    data['id'] = id;
    data['accountId'] = accountId;
    data['msgid'] = msgid;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.map((v) => v.toJson()).toList();
    }
    data['subject'] = subject;
    data['intro'] = intro;
    data['seen'] = seen;
    data['isDeleted'] = isDeleted;
    data['hasAttachments'] = hasAttachments;
    data['size'] = size;
    data['downloadUrl'] = downloadUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SenderReceiver {
  String? address;
  String? name;

  SenderReceiver({this.address, this.name});

  SenderReceiver.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['name'] = name;
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
