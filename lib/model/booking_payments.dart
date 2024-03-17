class BookingPayments {
  String? id;
  String? bookingId;
  String? userId;
  DateTime? date;
  int? amount;
  String? createdAt;
  String? updatedAt;
  int? v;

  BookingPayments({
    this.id,
    this.bookingId,
    this.userId,
    this.date,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BookingPayments.fromMap(Map<String, dynamic> json) => BookingPayments(
    id: json["_id"],
    bookingId: json["bookingId"],
    userId: json["userId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "bookingId": bookingId,
    "userId": userId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}