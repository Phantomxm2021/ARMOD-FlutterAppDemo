class RecommandARExperience {
  int? app_uid;
  int? user_uid;
  int? arexperience_uid;
  int? showcase_uid;
  String? showcase_name;
  String? showcase_brief;
  String? showcase_icon;
  String? showcase_header;
  List<dynamic>? showcase_not_index_tags;
  RecommandARExperience(
      {this.app_uid,
      this.user_uid,
      this.arexperience_uid,
      this.showcase_uid,
      this.showcase_brief,
      this.showcase_header,
      this.showcase_icon,
      this.showcase_name,
      this.showcase_not_index_tags});

  factory RecommandARExperience.fromJson(Map<String, dynamic> json) {
    return RecommandARExperience(
      app_uid: json['app_uid'],
      user_uid: json['user_uid'],
      arexperience_uid: json['arexperience_uid'],
      showcase_header: json['showcase_header'],
      showcase_uid: json['showcase_uid'],
      showcase_name: json['showcase_name'],
      showcase_brief: json['showcase_brief'],
      showcase_icon: json['showcase_icon'],
      showcase_not_index_tags: json['showcase_not_index_tags'],
    );
  }
}

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
