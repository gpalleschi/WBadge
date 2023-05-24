// import 'package:badge/models/type_time_stamp.dart';

// class TimeStamp {
//   late int typeTimeStamp;
//   late String time;

//   TimeStamp({
//     required this.typeTimeStamp,
//     required this.time,
//   });
  
// }

import 'dart:convert';

TimeStamp timeStampFromMap(String str) => TimeStamp.fromMap(json.decode(str));

String timeStampToMap(TimeStamp data) => json.encode(data.toMap());

class TimeStamp {
    int ?id;
    int ?day;
    int type;
    String time;

    TimeStamp({
        this.id,
        this.day,
        required this.type,
        required this.time,
    });

    factory TimeStamp.fromMap(Map<String, dynamic> json) => TimeStamp(
        id: json["id"],
        day: json["day"],
        type: json["type"],
        time: json["time"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "day": day,
        "type": type,
        "time": time,
    };

    @override
    String toString() {
           return 'id: $id day: $day type: $type time: $time';
    }
}
