class DueList {
  String? id;
  String? userId;
  String? name;
  String? mobile;
  num? due;

  DueList({
    this.id,
    this.userId,
    this.name,
    this.mobile,
    this.due,
  });

  factory DueList.fromMap(Map<String, dynamic> json) => DueList(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    due: json["due"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "due": due,
  };
}
