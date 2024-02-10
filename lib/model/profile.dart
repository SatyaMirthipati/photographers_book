class Profile {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? studio;
  String? address;
  bool? status;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? v;

  Profile({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.studio,
    this.address,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    password: json["password"],
    studio: json["studio"],
    address: json["address"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "password": password,
    "studio": studio,
    "address": address,
    "status": status,
    "role": role,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
