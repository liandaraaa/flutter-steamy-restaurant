import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/widgets/error_widget.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

import 'restaurant_detail_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routName = '/home_page';

  @override
  RestaurantListPageState createState() => RestaurantListPageState();
}

class RestaurantListPageState extends State<RestaurantListPage> {
  Widget appBarTitle = Text("Steamy Restaurant");
  Icon actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(
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
          return ErrorWidgetPage(
            message: state.message,
            image: 'images/ic_empty.png',
          );
        } else if (state.state == ResultState.Error) {
          return ErrorWidgetPage(
            message: state.message,
            image: 'images/ic_error.png',
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  onSubmitted: (text) {
                    Navigator.pushNamed(context, RestaurantSearchPage.routName,
                        arguments: text);
                  },
                );
              } else {
                this.actionIcon = Icon(Icons.search);
                this.appBarTitle = Text("Steamy Restaurant");
              }
            });
          },
        ),
      ]),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Material(
          child: appBarTitle,
        ),
        trailing: Material(
          child: IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(Icons.close);
                  this.appBarTitle = TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onSubmitted: (text) {
                      Navigator.pushNamed(
                          context, RestaurantSearchPage.routName,
                          arguments: text);
                    },
                  );
                } else {
                  this.actionIcon = Icon(Icons.search);
                  this.appBarTitle = Text("Steamy Restaurant");
                }
              });
            },
          ),
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
            child: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.pictureId,
                width: 100,
                fit: BoxFit.fill,
              ),
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
