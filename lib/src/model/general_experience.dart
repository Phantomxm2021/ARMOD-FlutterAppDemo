class GeneralExperence {
  int? statusCode;
  String? msg;
  Data? data;

  GeneralExperence({this.statusCode, this.msg, this.data});

  GeneralExperence.fromJson(Map<String, dynamic> json) {
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
  List<GeneralExperenceData>? allProject;
  int? count;

  Data({this.allProject, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all_project'] != null) {
      allProject = <GeneralExperenceData>[];
      json['all_project'].forEach((v) {
        allProject!.add(new GeneralExperenceData.fromJson(v));
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

class GeneralExperenceData {
  int? appUid;
  int? projectUid;
  String? projectName;
  String? projectIcon;
  String? projectBrief;
  String? createTime;
  String? updateTime;
  int? projectType;

  GeneralExperenceData(
      {this.appUid,
      this.projectUid,
      this.projectName,
      this.projectIcon,
      this.projectBrief,
      this.createTime,
      this.updateTime,
      this.projectType});

  GeneralExperenceData.fromJson(Map<String, dynamic> json) {
    appUid = json['app_uid'];
    projectUid = json['project_uid'];
    projectName = json['project_name'];
    projectIcon = json['project_icon'];
    projectBrief = json['project_brief'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    projectType = json['project_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_uid'] = this.appUid;
    data['project_uid'] = this.projectUid;
    data['project_name'] = this.projectName;
    data['project_icon'] = this.projectIcon;
    data['project_brief'] = this.projectBrief;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['project_type'] = this.projectType;
    return data;
  }
}
