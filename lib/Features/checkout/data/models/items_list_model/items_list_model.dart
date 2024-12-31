import 'item.dart';

class ItemsListModel {
  List<Item>? items;

  ItemsListModel({this.items});

  factory ItemsListModel.fromJson(Map<String, dynamic> json) {
    return ItemsListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
