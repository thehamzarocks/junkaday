class SpecificJunkLog {
  String userEmail;
  String junkItem;
  String createdTimeStamp;

  SpecificJunkLog({this.userEmail, this.junkItem, this.createdTimeStamp});

  factory SpecificJunkLog.fromJson(Map<String, dynamic> json) {
    return SpecificJunkLog(
      userEmail: json['user_email'],
      junkItem: json['junkItem'],
      createdTimeStamp: json['createdTimeStamp']
    );
  }
}
