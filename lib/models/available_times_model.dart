
class AvailableTimes {
  FirstDay firstDay;
  FirstDay secondDay;

  AvailableTimes({this.firstDay, this.secondDay});

  AvailableTimes.fromJson(Map<String, dynamic> json) {
    firstDay = json['first_day'] != null
        ? new FirstDay.fromJson(json['first_day'])
        : null;
    secondDay = json['second_day'] != null
        ? new FirstDay.fromJson(json['second_day'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstDay != null) {
      data['first_day'] = this.firstDay.toJson();
    }
    if (this.secondDay != null) {
      data['second_day'] = this.secondDay.toJson();
    }
    return data;
  }
}

class FirstDay {
  String from;
  String to;
  String date;
  String name;
  List<String> available;

  FirstDay({this.from, this.to, this.date, this.name, this.available});

  FirstDay.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    date = json['date'];
    name = json['name'];
    available = json['available'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['name'] = this.name;
    data['available'] = this.available;
    return data;
  }
}
