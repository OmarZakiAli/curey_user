class DoctorModel {
  List<Doctors> doctors;
  List<Specialities> specialities;

  DoctorModel({this.doctors, this.specialities});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = new List<Doctors>();
      json['doctors'].forEach((v) {
        doctors.add(new Doctors.fromJson(v));
      });
    }
    if (json['specialities'] != null) {
      specialities = new List<Specialities>();
      json['specialities'].forEach((v) {
        specialities.add(new Specialities.fromJson(v));
      });
    }
   
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors.map((v) => v.toJson()).toList();
    }
    if (this.specialities != null) {
      data['specialities'] = this.specialities.map((v) => v.toJson()).toList();
    }
   
    return data;
  }
}

class Doctors {
  int id;
  String fullName;
  String speciality;
  String image;
  int cityId;
  bool offersCallup;
  String fees;
  double overallRating;

  Doctors(
      {this.id,
      this.fullName,
      this.speciality,
      this.image,
      this.cityId,
      this.offersCallup,
      this.fees,
      this.overallRating});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    speciality = json['speciality'];
    image = json['image'];
    cityId = json['city_id'];
    offersCallup = json['offers_callup'];
    fees = json['fees'];
    overallRating = json['overall_rating']+0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['speciality'] = this.speciality;
    data['image'] = this.image;
    data['city_id'] = this.cityId;
    data['offers_callup'] = this.offersCallup;
    data['fees'] = this.fees;
    data['overall_rating'] = this.overallRating;
    return data;
  }
}

class Specialities {
  int id;
  String name;

  Specialities({this.id, this.name});

  Specialities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
