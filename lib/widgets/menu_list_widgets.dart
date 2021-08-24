import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class MenuListWidget extends StatelessWidget {
  final Menus? menus;
  final bool isFood;

  MenuListWidget({required this.menus, required this.isFood});

  @override
  Widget build(BuildContext context) {
    List list = List.empty();

    if (isFood) {
      list = menus?.foods ?? List.empty();
    } else {
      list = menus?.drinks ?? List.empty();
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _menuListItem(context, index + 1, list[index].name);
        });
  }

  Widget _menuListItem(BuildContext context, int index, String name) {
    return Container(
      child: Row(
        children: [
          Text("$index.".toString()),
          SizedBox(width: 6),
          Text(name),
        ],
      ),
      margin: EdgeInsets.all(8),
    );
  }
}
