class FeatureModel {
  int? featureId;
  String? featureName;
  String? featureDescription;

  FeatureModel({
    this.featureId,
    this.featureName,
    this.featureDescription,
  });

  FeatureModel.fromJson(Map<String, dynamic> json) {
    featureId = json['featureId'];
    featureName = json['featureName'];
    featureDescription = json['featureDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['featureId'] = featureId;
    data['featureName'] = featureName;
    data['featureDescription'] = featureDescription;
    return data;
  }

  dynamic operator [](String key) {
    switch (key) {
      case 'featureId':
        return featureId;
      case 'featureName':
        return featureName;
      case 'featureDescription':
        return featureDescription;
      default:
        return null;
    }
  }
}
