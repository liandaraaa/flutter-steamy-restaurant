import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/menu_list_widgets.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routName = '/restaurant_detail';

  final Restaurants restaurants;

  const RestaurantDetailPage({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          restaurants.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(restaurants.pictureId),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurants.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Divider(color: Colors.grey),
                      Text('Rating: ${restaurants.rating}'),
                      SizedBox(height: 10),
                      Text('City: ${restaurants.city}'),
                      Divider(color: Colors.grey),
                      Text(
                        restaurants.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text("Foods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 10),
                      MenuListWidget(menus: restaurants.menus, isFood: true),
                      SizedBox(height: 10),
                      Text("Drinks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 10),
                      MenuListWidget(menus: restaurants.menus, isFood: false)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
