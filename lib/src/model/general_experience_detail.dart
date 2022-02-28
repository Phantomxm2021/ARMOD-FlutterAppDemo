class GeneralExperenceDetail {
  int? app_uid;
  int? user_uid;
  int? arexperience_uid;
  int? showcase_uid;
  String? showcase_name;
  String? showcase_brief;
  String? showcase_icon;
  String? showcase_description;
  double? android_size;
  double? ios_size;
  String? showcase_header;

  List<dynamic>? showcase_not_index_tags;

  GeneralExperenceDetail(
      {this.app_uid,
      this.user_uid,
      this.arexperience_uid,
      this.showcase_uid,
      this.showcase_name,
      this.showcase_brief,
      this.showcase_icon,
      this.android_size,
      this.ios_size,
      this.showcase_header,
      this.showcase_description,
      this.showcase_not_index_tags});

  GeneralExperenceDetail.fromJson(Map<String, dynamic> json) {
    app_uid = json['app_uid'];
    user_uid = json['user_uid'];
    arexperience_uid = json['arexperience_uid'];
    showcase_uid = json['showcase_uid'];
    showcase_name = json['showcase_name'];
    showcase_brief = json['showcase_brief'];
    android_size = json['android_size'];
    ios_size = json['ios_size'];
    showcase_header = json['showcase_header'];
    showcase_description = json['showcase_description'];
    showcase_not_index_tags = json['showcase_not_index_tags'];
  }
}

class ARExperienceDetail {}
