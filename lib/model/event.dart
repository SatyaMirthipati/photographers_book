class Event {
  String? id;
  String? event;
  DateTime? date;
  List<String>? video;
  List<String>? camera;
  List<String>? drone;
  String? address;
  String? status;
  BookingDetails? bookingDetails;

  Event({
    this.id,
    this.event,
    this.date,
    this.video,
    this.camera,
    this.drone,
    this.address,
    this.status,
    this.bookingDetails,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
    id: json["_id"],
    event: json["event"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
    camera: json["camera"] == null ? [] : List<String>.from(json["camera"]!.map((x) => x)),
    drone: json["drone"] == null ? [] : List<String>.from(json["drone"]!.map((x) => x)),
    address: json["address"],
    status: json["status"],
    bookingDetails: json["bookingDetails"] == null ? null : BookingDetails.fromMap(json["bookingDetails"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "event": event,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
    "camera": camera == null ? [] : List<dynamic>.from(camera!.map((x) => x)),
    "drone": drone == null ? [] : List<dynamic>.from(drone!.map((x) => x)),
    "address": address,
    "status": status,
    "bookingDetails": bookingDetails?.toMap(),
  };
}

class BookingDetails {
  String? id;
  String? userId;
  String? name;
  String? mobile;
  String? status;

  BookingDetails({
    this.id,
    this.userId,
    this.name,
    this.mobile,
    this.status,
  });

  factory BookingDetails.fromMap(Map<String, dynamic> json) => BookingDetails(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "status": status,
  };
}