class GeneralExperence {
  int? app_uid;
  int? user_uid;
  int? arexperience_uid;
  int? showcase_uid;
  String? showcase_name;
  String? showcase_brief;
  String? showcase_icon;

  List<dynamic>? showcase_not_index_tags;

  GeneralExperence(
      {this.app_uid,
      this.user_uid,
      this.arexperience_uid,
      this.showcase_uid,
      this.showcase_name,
      this.showcase_brief,
      this.showcase_icon,
      this.showcase_not_index_tags});

  GeneralExperence.fromJson(Map<String, dynamic> json) {
    app_uid = json['app_uid'];
    user_uid = json['user_uid'];
    arexperience_uid = json['arexperience_uid'];
    showcase_uid = json['showcase_uid'];
    showcase_name = json['showcase_name'];
    showcase_icon = json['showcase_icon'];
    showcase_brief = json['showcase_brief'];
    showcase_not_index_tags = json['showcase_not_index_tags'];
  }
}
