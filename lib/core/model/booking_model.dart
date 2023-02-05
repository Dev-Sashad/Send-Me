class BookingModel {
  String? pickUp;
  String? dropOff;
  String? recieverNo;
  int? weight;
  String? uid;
  String? bookingDate;
  String? referenceId;
  String? deliveryStatus;

  BookingModel(
      {this.pickUp,
      this.dropOff,
      this.recieverNo,
      this.weight,
      this.uid,
      this.referenceId,
      this.deliveryStatus,
      this.bookingDate});

  BookingModel.fromJson(Map<String, dynamic> json) {
    pickUp = json["pickUp"] ?? "";
    dropOff = json["dropOff"] ?? "";
    weight = json["weight"] ?? "";
    recieverNo = json["recieverNo"] ?? "";
    uid = json['userId'] ?? '';
    referenceId = json['referenceId'] ?? "";
    bookingDate = json['bookingDate'] ?? DateTime.now().toString();
    deliveryStatus = json['deliveryStatus'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["pickUp"] = pickUp;
    data["dropOff"] = dropOff;
    data["weight"] = weight;
    data["recieverNo"] = recieverNo;
    data["userId"] = uid;
    data["referenceId"] = referenceId;
    data["bookingDate"] = bookingDate;
    data["deliveryStatus"] = deliveryStatus;
    return data;
  }
}