class BookingModel {
  String? date;
  String? importance;
  String? purpose;
  String? uid;
  String? name;
  String? bookingDate;
  String? referenceId;
  String? arrivalStatus;

  BookingModel(
      {this.date,
      this.importance,
      this.name,
      this.purpose,
      this.uid,
      this.referenceId,
      this.arrivalStatus,
      this.bookingDate});

  BookingModel.fromJson(Map<String, dynamic> json) {
    date = json["dateTime"] ?? "";
    importance = json["priority"] ?? '';
    purpose = json['purpose'];
    uid = json['userId'] ?? '';
    name = json['userName'] ?? "";
    referenceId = json['referenceId'] ?? "";
    bookingDate = json['bookingDate'] ?? DateTime.now().toString();
    arrivalStatus = json['arrivalStatus'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dateTime"] = date;
    data["priority"] = importance;
    data["purpose"] = purpose;
    data["userId"] = uid;
    data["userName"] = name;
    data["referenceId"] = referenceId;
    data["bookingDate"] = bookingDate;
    data["arrivalStatus"] = arrivalStatus;
    return data;
  }
}
