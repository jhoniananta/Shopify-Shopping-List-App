class ListItem {
  final String? id;
  final String title;
  final String category;
  final List<Item> items;

  ListItem(
      {this.id,
      required this.title,
      required this.category,
      required this.items});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class Item {
  String name;
  int quantity;
  String unit;
  bool isDone;

  Item({
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
