class AppointmentsModel {
  int id;
  String fullName;
  String address;
  String image;
  String speciality;
  String appTime;
  String duration;
  String fees;
  String lastCheckup;
  bool isCallup;
  bool reExam;

  AppointmentsModel(
      {this.id,
      this.fullName,
      this.address,
      this.image,
      this.speciality,
      this.appTime,
      this.duration,
      this.fees,
      this.lastCheckup,
      this.isCallup,
      this.reExam});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    address = json['address'];
    image = json['image'];
    speciality = json['speciality'];
    appTime = json['app_time'];
    duration = json['duration'];
    fees = json['fees'];
    lastCheckup = json['last_checkup'];
    isCallup = json['is_callup'];
    reExam = json['re_exam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['image'] = this.image;
    data['speciality'] = this.speciality;
    data['app_time'] = this.appTime;
    data['duration'] = this.duration;
    data['fees'] = this.fees;
    data['last_checkup'] = this.lastCheckup;
    data['is_callup'] = this.isCallup;
    data['re_exam'] = this.reExam;
    return data;
  }
}
