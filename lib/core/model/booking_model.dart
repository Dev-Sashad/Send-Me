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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dateTime"] = this.date;
    data["priority"] = this.importance;
    data["purpose"] = this.purpose;
    data["userId"] = this.uid;
    data["userName"] = this.name;
    data["referenceId"] = this.referenceId;
    data["bookingDate"] = this.bookingDate;
    data["arrivalStatus"] = this.arrivalStatus;
    return data;
  }
}
