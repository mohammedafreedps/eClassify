class SafetyTipsModel {
  int? id;
  int? tipId;
  int? languageId;
  String? description;
  String? createdAt;
  String? updatedAt;

  SafetyTipsModel(
      {this.id,
      this.tipId,
      this.languageId,
      this.description,
      this.createdAt,
      this.updatedAt});

  SafetyTipsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipId = json['tip_id'];
    languageId = json['language_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tip_id'] = this.tipId;
    data['language_id'] = this.languageId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
