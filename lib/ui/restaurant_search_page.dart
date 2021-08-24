import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routName = '/restaurant_search';

  String query = '';

  RestaurantSearchPage({required this.query});

  @override
  RestaurantSearchPageState createState() => RestaurantSearchPageState(query: query);
}

class RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String query = '';

  RestaurantSearchPageState({required this.query});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: query),
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.response.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.response.restaurants[index];
              return _buildRestaurantItem(context, restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(query)),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(query,
        ),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
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
          Navigator.pushNamed(context, RestaurantPage.routName,
              arguments: restaurant);
        },
      ),
    );
  }
}
