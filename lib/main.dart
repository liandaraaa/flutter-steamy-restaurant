import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steamy Restaurant',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: RestaurantListPage.routName,
      routes: {
        RestaurantListPage.routName: (context) => RestaurantListPage(),
      },
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  static const routName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steamy Restaurant'),
      ),
      body: FutureBuilder<String>(
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
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurants restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.description),
    );
  }
}
