import 'package:exercise/models/response_models/email_list_response.dart';

class EmailDetailsResponse {
  String? context;
  String? atId;
  String? type;
  String? id;
  String? accountId;
  String? msgid;
  SenderReceiver? from;
  List<SenderReceiver>? to;
  List<SenderReceiver>? cc;
  List<SenderReceiver>? bcc;
  String? subject;
  bool? seen;
  bool? flagged;
  bool? isDeleted;
  List<dynamic>? verifications;
  bool? retention;
  String? retentionDate;
  String? text;
  List<String>? html;
  bool? hasAttachments;
  List<Attachments>? attachments;
  int? size;
  String? downloadUrl;
  String? createdAt;
  String? updatedAt;

  EmailDetailsResponse(
      {this.context,
      this.id,
      this.type,
      this.atId,
      this.accountId,
      this.msgid,
      this.from,
      this.to,
      this.cc,
      this.bcc,
      this.subject,
      this.seen,
      this.flagged,
      this.isDeleted,
      this.verifications,
      this.retention,
      this.retentionDate,
      this.text,
      this.html,
      this.hasAttachments,
      this.attachments,
      this.size,
      this.downloadUrl,
      this.createdAt,
      this.updatedAt});

  EmailDetailsResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    atId = json['@id'];
    type = json['@type'];
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
    if (json['cc'] != null) {
      cc = <SenderReceiver>[];
      json['cc'].forEach((v) {
        cc!.add(SenderReceiver.fromJson(v));
      });
    }
    if (json['bcc'] != null) {
      bcc = <SenderReceiver>[];
      json['bcc'].forEach((v) {
        bcc!.add(SenderReceiver.fromJson(v));
      });
    }
    subject = json['subject'];
    seen = json['seen'];
    flagged = json['flagged'];
    isDeleted = json['isDeleted'];

    retention = json['retention'];
    retentionDate = json['retentionDate'];
    text = json['text'];
    html = json['html'].cast<String>();
    hasAttachments = json['hasAttachments'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@context'] = context;
    data['@id'] = id;
    data['@type'] = type;
    data['id'] = id;
    data['accountId'] = accountId;
    data['msgid'] = msgid;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.map((v) => v.toJson()).toList();
    }
    if (cc != null) {
      data['cc'] = cc!.map((v) => v.toJson()).toList();
    }
    if (bcc != null) {
      data['bcc'] = bcc!.map((v) => v.toJson()).toList();
    }
    data['subject'] = subject;
    data['seen'] = seen;
    data['flagged'] = flagged;
    data['isDeleted'] = isDeleted;
    if (verifications != null) {
      data['verifications'] = verifications!.map((v) => v.toJson()).toList();
    }
    data['retention'] = retention;
    data['retentionDate'] = retentionDate;
    data['text'] = text;
    data['html'] = html;
    data['hasAttachments'] = hasAttachments;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['size'] = size;
    data['downloadUrl'] = downloadUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Attachments {
  String? id;
  String? filename;
  String? contentType;
  String? disposition;
  String? transferEncoding;
  bool? related;
  int? size;
  String? downloadUrl;

  Attachments(
      {this.id,
      this.filename,
      this.contentType,
      this.disposition,
      this.transferEncoding,
      this.related,
      this.size,
      this.downloadUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    contentType = json['contentType'];
    disposition = json['disposition'];
    transferEncoding = json['transferEncoding'];
    related = json['related'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['contentType'] = contentType;
    data['disposition'] = disposition;
    data['transferEncoding'] = transferEncoding;
    data['related'] = related;
    data['size'] = size;
    data['downloadUrl'] = downloadUrl;
    return data;
  }
}
