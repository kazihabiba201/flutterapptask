class DoctorModel {
  late String code;
  late String totalCount;
  late String totalPages;
  late List<DoctorList> doctorList;


  DoctorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    totalCount = json['total_count'] ?? '';
    totalPages = json['total_pages'] ?? '';
    doctorList = (json['doctor_list'] as List<dynamic>?)
        ?.map((v) => DoctorList.fromJson(v))
        .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['total_count'] = totalCount;
    data['total_pages'] = totalPages;
    data['doctor_list'] = doctorList.map((v) => v.toJson()).toList();
    return data;
  }

}
class DoctorList {
  String? doctorId;
  String? name;
  String? age;
  String? gender;
  String? regNumber;
  String? regBody;
  String? languagesSpeaks;
  String? specialization;
  String? affiliation;
  String? currentInstitute;
  int? patientTreated;
  List<String>? days;
  String?visitFee;
  String?followUpFee;
  String?followupWithin;
  String?doctorType;
  String?trainingCourse;
  String?qualification;
  String?availability;
  String?profileImg;
  List<String>? consultationHour;

  DoctorList(
      {this.doctorId,
        this.name,
        this.age,
        this.gender,
        this.regNumber,
        this.regBody,
        this.languagesSpeaks,
        this.specialization,
        this.affiliation,
        this.currentInstitute,
        this.patientTreated,
        this.days,
        this.visitFee,
        this.followUpFee,
        this.followupWithin,
        this.doctorType,
        this.trainingCourse,
        this.qualification,
        this.availability,
        this.profileImg,
        this.consultationHour});

  DoctorList.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    regNumber = json['reg_number'];
    regBody = json['reg_body'];
    languagesSpeaks = json['languages_speaks'];
    specialization = json['specialization'];
    affiliation = json['affiliation'];
    currentInstitute = json['current_institute'];
    patientTreated = json['patient_treated'];
    days = json['days'].cast<String>();
    visitFee = json['visit_fee'];
    followUpFee = json['follow_up_fee'];
    followupWithin = json['followup_within'];
    doctorType = json['doctor_type'];
    trainingCourse = json['training_course'];
    qualification = json['qualification'];
    availability = json['availability'];
    profileImg = json['profile_img'];
    consultationHour = json['consultation_hour'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    data['reg_number'] = regNumber;
    data['reg_body'] = regBody;
    data['languages_speaks'] = languagesSpeaks;
    data['specialization'] = specialization;
    data['affiliation'] = affiliation;
    data['current_institute'] = currentInstitute;
    data['patient_treated'] = patientTreated;
    data['days'] = days;
    data['visit_fee'] = visitFee;
    data['follow_up_fee'] = followUpFee;
    data['followup_within'] = followupWithin;
    data['doctor_type'] = doctorType;
    data['training_course'] = trainingCourse;
    data['qualification'] = qualification;
    data['availability'] = availability;
    data['profile_img'] = profileImg;
    data['consultation_hour'] = consultationHour;
    return data;
  }
}