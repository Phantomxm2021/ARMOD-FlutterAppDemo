class RecommandARExperienceProject {
  int? id;
  int? app_uid;
  int? user_uid;
  int? project_id;
  String? project_name;
  String? project_brief;
  String? project_header;

  RecommandARExperienceProject({
    this.id,
    this.app_uid,
    this.user_uid,
    this.project_id,
    this.project_name,
    this.project_brief,
    this.project_header,
  });

  factory RecommandARExperienceProject.fromJson(Map<String, dynamic> json) {
    return RecommandARExperienceProject(
      app_uid: json['app_uid'],
      user_uid: json['user_uid'],
      project_id: json['project_id'],
      project_name: json['project_name'],
      project_brief: json['project_brief'],
      project_header: json['project_header'],
    );
  }
}
