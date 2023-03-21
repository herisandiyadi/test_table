class TableModel {
  TableModel({
    required this.itemid,
    required this.itemname,
    required this.barcode,
  });

  int itemid;
  String itemname;
  String barcode;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        itemid: json["itemid"],
        itemname: json["itemname"],
        barcode: json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "itemid": itemid,
        "itemname": itemname,
        "barcode": barcode,
      };
}
