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
  DateTime? dueDate;
  String? description;
  String? status;
  List<BookingsEvents>? events;
  List<BookingsSheets>? sheets;
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
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    description: json["description"],
    status: json["status"],
    events: json["events"] == null ? [] : List<BookingsEvents>.from(json["events"]!.map((x) => BookingsEvents.fromMap(x))),
    sheets: json["sheets"] == null ? [] : List<BookingsSheets>.from(json["sheets"]!.map((x) => BookingsSheets.fromMap(x))),
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
    "dueDate": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "description": description,
    "status": status,
    "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toMap())),
    "sheets": sheets == null ? [] : List<dynamic>.from(sheets!.map((x) => x.toMap())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class BookingsEvents {
  String? event;
  DateTime? date;
  List<String>? video;
  List<String>? camera;
  List<String>? drone;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? address;

  BookingsEvents({
    this.event,
    this.date,
    this.video,
    this.camera,
    this.drone,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  factory BookingsEvents.fromMap(Map<String, dynamic> json) => BookingsEvents(
    event: json["event"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
    camera: json["camera"] == null ? [] : List<String>.from(json["camera"]!.map((x) => x)),
    drone: json["drone"] == null ? [] : List<String>.from(json["drone"]!.map((x) => x)),
    status: json["status"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    address: json["address"],
  );

  Map<String, dynamic> toMap() => {
    "event": event,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
    "camera": camera == null ? [] : List<dynamic>.from(camera!.map((x) => x)),
    "drone": drone == null ? [] : List<dynamic>.from(drone!.map((x) => x)),
    "status": status,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "address": address,
  };
}

class BookingsSheets {
  String? sheet;
  String? quantity;
  String? id;
  String? createdAt;
  String? updatedAt;

  BookingsSheets({
    this.sheet,
    this.quantity,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingsSheets.fromMap(Map<String, dynamic> json) => BookingsSheets(
    sheet: json["sheet"],
    quantity: json["quantity"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toMap() => {
    "sheet": sheet,
    "quantity": quantity,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}