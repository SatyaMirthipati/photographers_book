class Sheet {
  String? id;
  String? userId;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? v;
  num? price;

  Sheet({
    this.id,
    this.userId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.price,
  });

  factory Sheet.fromMap(Map<String, dynamic> json) => Sheet(
    id: json["_id"],
    userId: json["userId"],
    type: json["type"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "userId": userId,
    "type": type,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "price": price,
  };
}