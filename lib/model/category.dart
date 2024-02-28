class Category {
  String? id;
  String? type;
  bool? status;
  String? category;
  String? createdAt;
  String? updatedAt;
  int? v;

  Category({
    this.id,
    this.type,
    this.status,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["_id"],
    type: json["type"],
    status: json["status"],
    category: json["category"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "type": type,
    "status": status,
    "category": category,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}