class RecommandARExperience {
  int? statusCode;
  String? msg;
  Data? data;

  RecommandARExperience({this.statusCode, this.msg, this.data});

  RecommandARExperience.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<RecommandProjectDetail>? allProject;
  int? count;

  Data({this.allProject, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all_project'] != null) {
      allProject = <RecommandProjectDetail>[];
      json['all_project'].forEach((v) {
        allProject!.add(new RecommandProjectDetail.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProject != null) {
      data['all_project'] = this.allProject!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class RecommandProjectDetail {
  int? projectUid;
  String? projectName;
  String? projectIcon;
  String? projectHeader;
  String? projectBrief;
  String? createTime;
  String? updateTime;
  int? projectType;

  RecommandProjectDetail(
      {this.projectUid,
      this.projectName,
      this.projectIcon,
      this.projectHeader,
      this.projectBrief,
      this.createTime,
      this.updateTime,
      this.projectType});

  RecommandProjectDetail.fromJson(Map<String, dynamic> json) {
    projectUid = json['project_uid'];
    projectName = json['project_name'];
    projectIcon = json['project_icon'];
    projectHeader = json['project_header'];
    projectBrief = json['project_brief'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectType = json['project_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_uid'] = this.projectUid;
    data['project_name'] = this.projectName;
    data['project_icon'] = this.projectIcon;
    data['project_header'] = this.projectHeader;
    data['project_brief'] = this.projectBrief;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_type'] = this.projectType;
    return data;
  }
}
