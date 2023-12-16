class Sheet {
  num? sheetId;
  num? clientId;
  String? sheetType;
  num? price;

  Sheet({
    this.sheetId,
    this.clientId,
    this.sheetType,
    this.price,
  });

  factory Sheet.fromMap(Map<String, dynamic> json) => Sheet(
    sheetId: json["SheetId"],
    clientId: json["ClientId"],
    sheetType: json["SheetType"],
    price: json["Price"],
  );

  Map<String, dynamic> toMap() => {
    "SheetId": sheetId,
    "ClientId": clientId,
    "SheetType": sheetType,
    "Price": price,
  };
}