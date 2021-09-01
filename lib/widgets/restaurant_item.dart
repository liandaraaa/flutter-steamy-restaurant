import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return _buildRestaurantItem(
                context, restaurant, isFavorite, provider);
          },
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant,
      bool isFavorite, DatabaseProvider provider) {
    var _basePictureUrl = "https://restaurant-api.dicoding.dev/images/medium/";
    String picture = _basePictureUrl + restaurant.pictureId;

    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Hero(
              tag: restaurant.id,
              child: Image.network(
                picture,
                width: 100,
                fit: BoxFit.fill,
              ),
            )),
        trailing: isFavorite
            ? IconButton(
                onPressed: () => provider.removeFavorite(restaurant.id),
                icon: Icon(Icons.favorite),
                color: Theme.of(context).accentColor,
              )
            : IconButton(
                onPressed: () => provider.addFavorite(restaurant),
                icon: Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
              ),
        title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            restaurant.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 10,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 10,
                ),
                Text(
                  restaurant.city,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantPage.routName,
              arguments: restaurant);
        },
      ),
    );
  }
}
