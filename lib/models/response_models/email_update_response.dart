class EmailUpdateResponse {
  String? context;
  String? id;
  String? type;
  bool? seen;

  EmailUpdateResponse({this.context, this.id, this.type, this.seen});

  EmailUpdateResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    id = json['@id'];
    type = json['@type'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@context'] = context;
    data['@id'] = id;
    data['@type'] = type;
    data['seen'] = seen;
    return data;
  }
}