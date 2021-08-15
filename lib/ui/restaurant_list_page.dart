import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

import 'restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final RestaurantData data = parseRestaurantData(snapshot.data);
        return ListView.builder(
            itemCount: data.restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, data.restaurants[index]);
            });
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Steamy Restaurant"),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Steamy Restaurant",
        ),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurants restaurant) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              restaurant.pictureId,
              width: 100,
              fit: BoxFit.fill,
            )),
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
          Navigator.pushNamed(context, RestaurantDetailPage.routName,
              arguments: restaurant);
        },
      ),
    );
  }
}
