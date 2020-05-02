class LocalizationModel {
  String onboard1Main;
  String onboard1Para;
  String next;
  String skip;
  String onboard2Main;
  String onboard2Para;
  String onboard3Main;
  String onboard3Para;
  String signup;
  String signin;
  String wel;
  String signAccount;
  String emailPhone;
  String eEmailPhone;
  String uPass;
  String ePass;
  String fPass;
  String dontHave;
  String fullName;
  String uName;
  String email;
  String uEmail;
  String city;
  String pass;
  String wPass;
  String cPass;
  String haveAcc;
  String home;
  String needHelp;
  String findDm;
  String searchDm;
  String medicine;
  String doctor;
  String appointments;
  String prescription;
  String orders;
  String notifications;
  String reviews;
  String bookNow;
  String homeVisit;
  String booking;
  String biography;
  String degrees;
  String profile;
  String contactInfo;
  String doctors;
  String searchDoctors;
  String book;
  String medications;
  String searchMedications;
  String buyNow;
  String deliveryCost;
  String basedAddress;
  String changeAddress;
  String pharmaciesList;
  String order;
  String addCart;
  String le;
  String all;
  String callUp;
  String reExam;
  String sentYou;

  LocalizationModel(
      {this.onboard1Main,
      this.onboard1Para,
      this.next,
      this.skip,
      this.onboard2Main,
      this.onboard2Para,
      this.onboard3Main,
      this.onboard3Para,
      this.signup,
      this.signin,
      this.wel,
      this.signAccount,
      this.emailPhone,
      this.eEmailPhone,
      this.uPass,
      this.ePass,
      this.fPass,
      this.dontHave,
      this.fullName,
      this.uName,
      this.email,
      this.uEmail,
      this.city,
      this.pass,
      this.wPass,
      this.cPass,
      this.haveAcc,
      this.home,
      this.needHelp,
      this.findDm,
      this.searchDm,
      this.medicine,
      this.doctor,
      this.appointments,
      this.prescription,
      this.orders,
      this.notifications,
      this.reviews,
      this.bookNow,
      this.homeVisit,
      this.booking,
      this.biography,
      this.degrees,
      this.profile,
      this.contactInfo,
      this.doctors,
      this.searchDoctors,
      this.book,
      this.medications,
      this.searchMedications,
      this.buyNow,
      this.deliveryCost,
      this.basedAddress,
      this.changeAddress,
      this.pharmaciesList,
      this.order,
      this.addCart,
      this.le,
      this.all,
      this.callUp,
      this.reExam,
      this.sentYou});

  LocalizationModel.fromJson(Map<String, dynamic> json) {
    onboard1Main = json['onboard1_main'];
    onboard1Para = json['onboard1_para'];
    next = json['next'];
    skip = json['skip'];
    onboard2Main = json['onboard2_main'];
    onboard2Para = json['onboard2_para'];
    onboard3Main = json['onboard3_main'];
    onboard3Para = json['onboard3_para'];
    signup = json['signup'];
    signin = json['signin'];
    wel = json['wel'];
    signAccount = json['sign_account'];
    emailPhone = json['email_phone'];
    eEmailPhone = json['e_email_phone'];
    uPass = json['u_pass'];
    ePass = json['e_pass'];
    fPass = json['f_pass'];
    dontHave = json['dont_have'];
    fullName = json['full_name'];
    uName = json['u_name'];
    email = json['email'];
    uEmail = json['u_email'];
    city = json['city'];
    pass = json['pass'];
    wPass = json['w_pass'];
    cPass = json['c_pass'];
    haveAcc = json['have_acc'];
    home = json['home'];
    needHelp = json['need_help'];
    findDm = json['find_dm'];
    searchDm = json['search_dm'];
    medicine = json['medicine'];
    doctor = json['doctor'];
    appointments = json['appointments'];
    prescription = json['prescription'];
    orders = json['orders'];
    notifications = json['notifications'];
    reviews = json['reviews'];
    bookNow = json['book_now'];
    homeVisit = json['home_visit'];
    booking = json['booking'];
    biography = json['biography'];
    degrees = json['degrees'];
    profile = json['profile'];
    contactInfo = json['contact_info'];
    doctors = json['doctors'];
    searchDoctors = json['search_doctors'];
    book = json['book'];
    medications = json['medications'];
    searchMedications = json['search_medications'];
    buyNow = json['buy_now'];
    deliveryCost = json['delivery_cost'];
    basedAddress = json['based_address'];
    changeAddress = json['change_address'];
    pharmaciesList = json['pharmacies_list'];
    order = json['order'];
    addCart = json['add_cart'];
    le = json['le'];
    all = json['all'];
    callUp = json['call_up'];
    reExam = json['re_exam'];
    sentYou = json['sent_you'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onboard1_main'] = this.onboard1Main;
    data['onboard1_para'] = this.onboard1Para;
    data['next'] = this.next;
    data['skip'] = this.skip;
    data['onboard2_main'] = this.onboard2Main;
    data['onboard2_para'] = this.onboard2Para;
    data['onboard3_main'] = this.onboard3Main;
    data['onboard3_para'] = this.onboard3Para;
    data['signup'] = this.signup;
    data['signin'] = this.signin;
    data['wel'] = this.wel;
    data['sign_account'] = this.signAccount;
    data['email_phone'] = this.emailPhone;
    data['e_email_phone'] = this.eEmailPhone;
    data['u_pass'] = this.uPass;
    data['e_pass'] = this.ePass;
    data['f_pass'] = this.fPass;
    data['dont_have'] = this.dontHave;
    data['full_name'] = this.fullName;
    data['u_name'] = this.uName;
    data['email'] = this.email;
    data['u_email'] = this.uEmail;
    data['city'] = this.city;
    data['pass'] = this.pass;
    data['w_pass'] = this.wPass;
    data['c_pass'] = this.cPass;
    data['have_acc'] = this.haveAcc;
    data['home'] = this.home;
    data['need_help'] = this.needHelp;
    data['find_dm'] = this.findDm;
    data['search_dm'] = this.searchDm;
    data['medicine'] = this.medicine;
    data['doctor'] = this.doctor;
    data['appointments'] = this.appointments;
    data['prescription'] = this.prescription;
    data['orders'] = this.orders;
    data['notifications'] = this.notifications;
    data['reviews'] = this.reviews;
    data['book_now'] = this.bookNow;
    data['home_visit'] = this.homeVisit;
    data['booking'] = this.booking;
    data['biography'] = this.biography;
    data['degrees'] = this.degrees;
    data['profile'] = this.profile;
    data['contact_info'] = this.contactInfo;
    data['doctors'] = this.doctors;
    data['search_doctors'] = this.searchDoctors;
    data['book'] = this.book;
    data['medications'] = this.medications;
    data['search_medications'] = this.searchMedications;
    data['buy_now'] = this.buyNow;
    data['delivery_cost'] = this.deliveryCost;
    data['based_address'] = this.basedAddress;
    data['change_address'] = this.changeAddress;
    data['pharmacies_list'] = this.pharmaciesList;
    data['order'] = this.order;
    data['add_cart'] = this.addCart;
    data['le'] = this.le;
    data['all'] = this.all;
    data['call_up'] = this.callUp;
    data['re_exam'] = this.reExam;
    data['sent_you'] = this.sentYou;
    return data;
  }
}
