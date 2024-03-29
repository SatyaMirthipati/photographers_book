import 'event.dart';

class BookingSheet {
  String? id;
  String? sheet;
  String? quantity;
  BookingDetails? bookingDetails;

  BookingSheet({
    this.id,
    this.sheet,
    this.quantity,
    this.bookingDetails,
  });

  factory BookingSheet.fromMap(Map<String, dynamic> json) => BookingSheet(
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
