class PrescriptionModel {
  int id;
  String medicine;
  String dosage;
  int frequency;
  List<String> days;
  List<String> dosageTime;

  PrescriptionModel(
      {this.id,
      this.medicine,
      this.dosage,
      this.frequency,
      this.days,
      this.dosageTime});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicine = json['medicine'];
    dosage = json['dosage'];
    frequency = json['frequency'];
    days = json['Days'].cast<String>();
    dosageTime = json['dosage_time'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicine'] = this.medicine;
    data['dosage'] = this.dosage;
    data['frequency'] = this.frequency;
    data['Days'] = this.days;
    data['dosage_time'] = this.dosageTime;
    return data;
  }
}
