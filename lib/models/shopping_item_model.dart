final String tableNotes = 'ShoppingCart';


class ItemFields {
  static final List<String> values = [
    /// Add all fields
    id, itemName, itemPrice
  ];

  static final String id = '_id';
  static final String itemName = 'title';
  static final String itemPrice = 'description';
}


class ShoppingItem {
  final int? id;
  late String itemName;
  late int itemPrice;

  ShoppingItem({this.id, required this.itemName, required this.itemPrice});

  ShoppingItem copy({
    final int? id,
    final String? itemName,
    final int? itemPrice,
  }) =>
      ShoppingItem(
        id: id ?? this.id,
        itemName: itemName ?? this.itemName,
        itemPrice: itemPrice ?? this.itemPrice,
      );

  static ShoppingItem fromJson(Map<String, Object?> json) => ShoppingItem(
        id: json[ItemFields.id] as int?,
        itemName: json[ItemFields.itemName] as String,
        itemPrice: json[ItemFields.itemPrice] as int,
      );

  Map<String, Object?> toJson() => {
        ItemFields.id: id,
        ItemFields.itemName: itemName,
        ItemFields.itemPrice: itemPrice,
      };

}