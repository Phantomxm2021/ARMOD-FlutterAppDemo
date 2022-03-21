import "dart:convert";

class GeneralV2ExperenceDetail {
  int? app_uid;
  int? user_uid;
  int? project_id;
  String? project_name;
  String? project_icon;
  String? project_header;
  String? project_description;
  List<dynamic>? project_preview;

  GeneralV2ExperenceDetail(
      {this.app_uid,
      this.user_uid,
      this.project_id,
      this.project_name,
      this.project_icon,
      this.project_description,
      this.project_header,
      this.project_preview});

  GeneralV2ExperenceDetail.fromJson(Map<String, dynamic> json) {
    app_uid = json['app_uid'];
    user_uid = json['user_uid'];
    project_id = json['project_id'];
    project_name = json['project_name'];
    project_icon = json['project_icon'];
    project_description = json['project_description'];
    project_header = json['project_header'];
    if (json['project_preview'] == "")
      project_preview = [];
    else
      project_preview = json['project_preview'];
  }
}
