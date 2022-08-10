class GeneralExperence {
  int? app_uid;
  int? user_uid;
  int? project_id;
  String? project_name;
  String? project_brief;
  String? project_icon;


  GeneralExperence(
      {this.app_uid,
      this.user_uid,
      this.project_id,
      this.project_name,
      this.project_brief,
      this.project_icon});

  GeneralExperence.fromJson(Map<String, dynamic> json) {
    app_uid = json['app_uid'];
    user_uid = json['user_uid'];
    project_id = json['project_id'];
    project_name = json['project_name'];
    project_icon = json['project_icon'];
    project_brief = json['project_brief'];
  }
}
