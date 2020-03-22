import 'package:flutter/cupertino.dart';

enum CoronaStatus {
  NOT_TESTED,
  IN_PROGRESS,
  POSITIVE,
  NEGATIVE
}

CoronaStatus getCoronaStatusFromString(String status) {
  status = 'CoronaStatus.$status';
  return CoronaStatus.values.firstWhere((f)=> f.toString() == status, orElse: () => null);
}

class CoronaTestCase {
  String nickname;
  final String uuidRead;
  final String uuidWrite;
  final CoronaStatus infected;
  final String date;

  CoronaTestCase({
    @required this.nickname,
    @required this.uuidRead,
    @required this.uuidWrite,
    @required this.infected,
    @required this.date
  });

  String getReadURL() {
    return '/corona-test-case/${this.uuidRead}';
  }

  factory CoronaTestCase.fromJson(Map<String, dynamic> json) {
    return new CoronaTestCase(
        nickname: json["uuid_read"],
        uuidRead: json["uuid_read"],
        uuidWrite: json["uuid_write"],
        infected: getCoronaStatusFromString(json["infected"]),
        date: json["date"]
    );
  }
}