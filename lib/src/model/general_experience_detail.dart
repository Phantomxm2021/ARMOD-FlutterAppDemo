class GeneralExperenceDetail {
  int? app_uid;
  int? user_uid;
  int? project_id;
  String? project_name;
  String? project_brief;
  String? project_icon;
  String? project_header;
  String? project_description;

  List<dynamic>? showcase_not_index_tags;

  GeneralExperenceDetail(
      {this.app_uid,
      this.user_uid,
      this.project_id,
      this.project_name,
      this.project_brief,
      this.project_icon,
      this.project_description,
   });

  GeneralExperenceDetail.fromJson(Map<String, dynamic> json) {
    app_uid = json['app_uid'];
    user_uid = json['user_uid'];
    project_id = json['project_id'];
    project_name = json['project_name'];
    project_brief = json['project_brief'];
    project_header = json['project_header'];
    project_icon=json['project_icon'];
    project_description=json['project_description'];
  }
}
