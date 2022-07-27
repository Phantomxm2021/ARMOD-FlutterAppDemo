class RecommandARExperience {
  int? app_uid;
  int? user_uid;
  int? arexperience_uid;
  int? project_id;
  String? project_name;
  String? project_brief;
  String? showcase_icon;
  String? project_header;
  List<dynamic>? showcase_not_index_tags;
  RecommandARExperience(
      {this.app_uid,
      this.user_uid,
      this.arexperience_uid,
      this.project_id,
      this.project_brief,
      this.project_header,
      this.showcase_icon,
      this.project_name,
      this.showcase_not_index_tags});

   factory RecommandARExperience.fromJson(Map<String, dynamic> json) {
    return RecommandARExperience(
      app_uid: json['app_uid'],
      user_uid: json['user_uid'],
      arexperience_uid: json['arexperience_uid'],
      project_header: json['project_header'],
      project_id: json['project_id'],
      project_name: json['project_name'],
      project_brief: json['project_brief'],
      showcase_icon: json['showcase_icon'],
      showcase_not_index_tags: json['showcase_not_index_tags'],
    );
  }
}
