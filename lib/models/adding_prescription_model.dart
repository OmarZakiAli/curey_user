class AddingPrescriptionModel {
  String apiToken;
  String medicineName;
  String dosage;
  String startHour;
  String endDate;
  int frequency;
  List<int> days;
  List<String> hours;
  int auto;

  AddingPrescriptionModel(
      {this.apiToken,
      this.medicineName,
      this.dosage="1 pill",
      this.startHour,
      this.endDate="2020-12-6",
      this.frequency,
      this.days,
      this.hours,
      this.auto});

  AddingPrescriptionModel.fromJson(Map<String, dynamic> json) {
    apiToken = json['api_token'];
    medicineName = json['medicine_name'];
    dosage = json['dosage'];
    startHour = json['start_hour'];
    endDate = json['end_date'];
    frequency = json['frequency'];
    days = json['days'].cast<int>();
    hours = json['hours'].cast<String>();
    auto = json['auto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_token'] = this.apiToken;
    data['medicine_name'] = this.medicineName;
    data['dosage'] = this.dosage;
    data['start_hour'] = this.startHour;
    data['end_date'] = this.endDate;
    data['frequency'] = this.frequency;
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['auto'] = this.auto;
    return data;
  }
}
