import 'event.dart';

class BookingSheets {
  String? id;
  String? sheet;
  String? quantity;
  BookingDetails? bookingDetails;

  BookingSheets({
    this.id,
    this.sheet,
    this.quantity,
    this.bookingDetails,
  });

  factory BookingSheets.fromMap(Map<String, dynamic> json) => BookingSheets(
    id: json["_id"],
    sheet: json["sheet"],
    quantity: json["quantity"],
    bookingDetails: json["bookingDetails"] == null ? null : BookingDetails.fromMap(json["bookingDetails"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "sheet": sheet,
    "quantity": quantity,
    "bookingDetails": bookingDetails?.toMap(),
  };
}
