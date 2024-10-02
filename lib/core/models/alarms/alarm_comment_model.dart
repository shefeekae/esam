
class AlarmComments {
  List<GetComments>? getComments;

  AlarmComments({this.getComments});

  AlarmComments.fromJson(Map<String, dynamic> json) {
    if (json['getComments'] != null) {
      getComments = <GetComments>[];
      json['getComments'].forEach((v) {
        getComments!.add( GetComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (getComments != null) {
      data['getComments'] = getComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetComments {
  String? eventId;
  int? commentTime;
  String? username;
  String? comment;
  String? type;

  GetComments(
      {this.eventId, this.commentTime, this.username, this.comment, this.type});

  GetComments.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    commentTime = json['commentTime'];
    username = json['username'];
    comment = json['comment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['commentTime'] = commentTime;
    data['username'] = username;
    data['comment'] = comment;
    data['type'] = type;
    return data;
  }
}
