class Event {
  String? event;
  String? date;
  String? video;
  String? camera;
  String? drone;
  String? resource;
  String? id;
  String? createdAt;
  String? updatedAt;

  Event({
    this.event,
    this.date,
    this.video,
    this.camera,
    this.drone,
    this.resource,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
    event: json["event"],
    date: json["date"],
    video: json["video"],
    camera: json["camera"],
    drone: json["drone"],
    resource: json["resource"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toMap() => {
    "event": event,
    "date": date,
    "video": video,
    "camera": camera,
    "drone": drone,
    "resource": resource,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}