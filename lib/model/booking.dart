import 'event.dart';
import 'sheet.dart';

class Booking {
  String? id;
  String? userId;
  String? name;
  String? mobile;
  String? address;
  int? total;
  int? discount;
  int? extra;
  int? payable;
  int? paid;
  int? due;
  String? dueDate;
  String? description;
  bool? status;
  List<Event>? events;
  List<Sheet>? sheets;
  String? createdAt;
  String? updatedAt;
  int? v;

  Booking({
    this.id,
    this.userId,
    this.name,
    this.mobile,
    this.address,
    this.total,
    this.discount,
    this.extra,
    this.payable,
    this.paid,
    this.due,
    this.dueDate,
    this.description,
    this.status,
    this.events,
    this.sheets,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    total: json["total"],
    discount: json["discount"],
    extra: json["extra"],
    payable: json["payable"],
    paid: json["paid"],
    due: json["due"],
    dueDate: json["dueDate"],
    description: json["description"],
    status: json["status"],
    events: json["events"] == null ? [] : List<Event>.from(json["events"]!.map((x) => Event.fromMap(x))),
    sheets: json["sheets"] == null ? [] : List<Sheet>.from(json["sheets"]!.map((x) => Sheet.fromMap(x))),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "address": address,
    "total": total,
    "discount": discount,
    "extra": extra,
    "payable": payable,
    "paid": paid,
    "due": due,
    "dueDate": dueDate,
    "description": description,
    "status": status,
    "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toMap())),
    "sheets": sheets == null ? [] : List<dynamic>.from(sheets!.map((x) => x.toMap())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
