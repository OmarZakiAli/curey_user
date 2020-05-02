class DoctorDetailModel {
  Doctor doctor;
  List<Reviews> reviews=[];

  DoctorDetailModel({this.doctor, this.reviews});

  DoctorDetailModel.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;

    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String id;
  String fullName;
  String speciality;
  String image;
  String qualifications;
  String fees;
  bool offersCallup;
  String callupFees;
  String address;
  String mobile;
  String email;
  double overallRating;
  List<String> degrees;

  Doctor(
      {this.id,
      this.fullName,
      this.speciality,
      this.image,
      this.qualifications,
      this.fees,
      this.offersCallup,
      this.callupFees,
      this.address,
      this.mobile,
      this.email,
      this.overallRating,
      this.degrees});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    speciality = json['speciality'];
    image = json['image'];
    qualifications = json['qualifications'];
    fees = json['fees'];
    offersCallup = json['offers_callup'];
    callupFees = json['callup_fees'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
    overallRating = json['overall_rating']+0.0;
    degrees = json['degrees'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['speciality'] = this.speciality;
    data['image'] = this.image;
    data['qualifications'] = this.qualifications;
    data['fees'] = this.fees;
    data['offers_callup'] = this.offersCallup;
    data['callup_fees'] = this.callupFees;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['overall_rating'] = this.overallRating;
    data['degrees'] = this.degrees;
    return data;
  }
}

class Reviews {
  double rating;
  String fullName;
  String review;
  String image;

  Reviews({this.rating, this.fullName, this.review, this.image});

  Reviews.fromJson(Map<String, dynamic> json) {
    rating = json['rating']+0.0;
    fullName = json['full_name'];
    review = json['review'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['full_name'] = this.fullName;
    data['review'] = this.review;
    data['image'] = this.image;
    return data;
  }
}
