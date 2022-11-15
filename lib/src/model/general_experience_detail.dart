class GeneralExperenceDetail {
  int? statusCode;
  String? msg;
  ProjectDetailData? data;

  GeneralExperenceDetail({this.statusCode, this.msg, this.data});

  GeneralExperenceDetail.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new ProjectDetailData.fromJson(json['data']) : null;
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

class ProjectDetailData {
  String? createTime;
  String? updateTime;
  int? appUid;
  int? projectUid;
  String? projectName;
  String? projectBrief;
  String? projectIcon;
  String? projectHeader;
  String? projectPreviews;
  String? projectDescription;
  int? projectType;

  ProjectDetailData(
      {this.createTime,
      this.updateTime,
      this.appUid,
      this.projectUid,
      this.projectName,
      this.projectBrief,
      this.projectIcon,
      this.projectHeader,
      this.projectPreviews,
      this.projectDescription,
      this.projectType});

  ProjectDetailData.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    updateTime = json['update_time'];
    appUid = json['app_uid'];
    projectUid = json['project_uid'];
    projectName = json['project_name'];
    projectBrief = json['project_brief'];
    projectIcon = json['project_icon'];
    projectHeader = json['project_header'];
    projectPreviews = json['project_previews'];
    projectDescription = json['project_description'];
    projectType = json['project_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['app_uid'] = this.appUid;
    data['project_uid'] = this.projectUid;
    data['project_name'] = this.projectName;
    data['project_brief'] = this.projectBrief;
    data['project_icon'] = this.projectIcon;
    data['project_header'] = this.projectHeader;
    data['project_previews'] = this.projectPreviews;
    data['project_description'] = this.projectDescription;
    data['project_type'] = this.projectType;
    return data;
  }
}
