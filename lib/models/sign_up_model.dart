class UserSignUpModel {
  String userName;
  String email;
  String password;
  int city=1;


  UserSignUpModel({this.userName="omaroooooooo",this.email="zamrmdars@gmail.com",this.password="11111111111",this.city=1});

  toJson() {
    return {
      "full_name": userName,
      "email": email,
      "password": password,
      "role_id": 1,
      "city_id": city==null?1:city
    };
  }
}
