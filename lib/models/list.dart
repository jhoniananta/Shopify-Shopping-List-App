class ListItem {
  final String? id;
  final String title;
  final String category;
  final Map<String, Item> items;

  ListItem(
      {this.id,
      required this.title,
      required this.category,
      required this.items});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'items': items.map((key, value) => MapEntry(key, value.toMap())),
    };
  }
}

class Item {
  String id;
  String name;
  String quantity;
  String unit;
  bool isDone;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'isDone': isDone,
    };
  }
}
