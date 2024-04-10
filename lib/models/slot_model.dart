class SlotModel {
  String? slotDate;
  String? slotFromDateTime;
  String? slotToDateTime;
  String? slotPrice;
  int? slotId;

  SlotModel({
    this.slotDate,
    required this.slotFromDateTime,
    this.slotToDateTime,
    this.slotPrice,
    this.slotId,
  });

  SlotModel.fromJson(Map<String, dynamic> json) {
    slotDate = json['slotDate'];
    slotFromDateTime = json['slotFromDateTime'];
    slotToDateTime = json['slotToDateTime'];
    slotPrice = json['slotPrice'];
    slotId = json['slotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slotDate'] = slotDate;
    data['slotFromDateTime'] = slotFromDateTime;
    data['slotToDateTime'] = slotToDateTime;
    data['slotPrice'] = slotPrice;
    data['slotId'] = slotId;
    return data;
  }

  dynamic operator [](String key) {
    switch (key) {
      case 'slotDate':
        return slotDate;
      case 'slotFromDateTime':
        return slotFromDateTime;
      case 'slotToDateTime':
        return slotToDateTime;
      case 'slotPrice':
        return slotPrice;
      case 'slotId':
        return slotId;
      default:
        return null;
    }
  }
}
