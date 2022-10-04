class SignUpSuccessResponse {
  String? context;
  String? atId;
  String? type;
  String? id;
  String? address;
  int? quota;
  int? used;
  bool? isDisabled;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  SignUpSuccessResponse(
      {this.context,
      this.id,
      this.type,
      this.atId,
      this.address,
      this.quota,
      this.used,
      this.isDisabled,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  SignUpSuccessResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    atId = json['@id'];
    type = json['@type'];
    id = json['id'];
    address = json['address'];
    quota = json['quota'];
    used = json['used'];
    isDisabled = json['isDisabled'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class InvalidSignUpInput {
  String? context;
  String? type;
  String? hydraTitle;
  String? hydraDescription;

  InvalidSignUpInput(
      {this.context, this.type, this.hydraTitle, this.hydraDescription});

  InvalidSignUpInput.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    hydraTitle = json['hydra:title'];
    hydraDescription = json['hydra:description'];
  }
}

class SignUpFailedResponse {
  String? context;
  String? type;
  String? hydraTitle;
  String? hydraDescription;
  List<Violations>? violations;

  SignUpFailedResponse(
      {this.context,
      this.type,
      this.hydraTitle,
      this.hydraDescription,
      this.violations});

  SignUpFailedResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    hydraTitle = json['hydra:title'];
    hydraDescription = json['hydra:description'];
    if (json['violations'] != null) {
      violations = <Violations>[];
      json['violations'].forEach((v) {
        violations!.add(Violations.fromJson(v));
      });
    }
  }
}

class Violations {
  String? propertyPath;
  String? message;
  String? code;

  Violations({this.propertyPath, this.message, this.code});

  Violations.fromJson(Map<String, dynamic> json) {
    propertyPath = json['propertyPath'];
    message = json['message'];
    code = json['code'];
  }
}
